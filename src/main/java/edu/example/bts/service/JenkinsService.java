package edu.example.bts.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.offbytwo.jenkins.JenkinsServer;
import com.offbytwo.jenkins.client.JenkinsHttpClient;
import com.offbytwo.jenkins.model.Build;
import com.offbytwo.jenkins.model.BuildResult;
import com.offbytwo.jenkins.model.JobWithDetails;
import com.offbytwo.jenkins.model.QueueItem;
import com.offbytwo.jenkins.model.QueueReference;

import edu.example.bts.dao.JenkinsDAO;
import edu.example.bts.domain.jenkins.JCommitDTO;

@Service
public class JenkinsService {

	private static final MediaType TEXT_UTF8 =
		    new MediaType("text", "plain", StandardCharsets.UTF_8); // emitter logchunk 보낼때 한글 깨짐 방지용
	@Autowired
	JenkinsDAO jenkinsDAO;
	
	String user = "test1";
	String token = "11de287229e552b77c029bb87098ad3c6d"; // token & password 둘다 가능
	String jenkinsUrl = "http://localhost:9000";
	
	private JenkinsServer getJenkinsServer() {
		try {
            return new JenkinsServer(new URI(jenkinsUrl), user, token);
        } catch (Exception e) {
            
            throw new RuntimeException("Jenkins 서버 연결 실패", e);
        }
	}
	private JenkinsHttpClient getJenkinsHttpClient() {
        try {
            return new JenkinsHttpClient(new URI(jenkinsUrl), user, token);
        } catch (Exception e) {
            throw new RuntimeException("Jenkins HttpClient 생성 실패", e);
        }
    }
	
	
	public List<JCommitDTO> getCommitList(){
		return jenkinsDAO.getCommitList();
	}
	
	
	public List<JCommitDTO> getCommitFiles(){
		List<Long> reqIds = jenkinsDAO.getAwaitedReqIds();
		List<JCommitDTO> commits = new ArrayList<>();
		for(Long reqId : reqIds) {
			commits.addAll(jenkinsDAO.getCommitListByReqId(reqId));
			jenkinsDAO.updateResult(reqId, "process", null);
		}
		
		
		return commits;
	}
	
	public Long triggerBuildNow(String projectName) {
	    try {
	        JenkinsServer jenkins = getJenkinsServer();
	        JobWithDetails job = jenkins.getJob(projectName);
	        
	        QueueReference queueRef = job.build(); 
	        long timeout = 60_000; // 최대 60초 대기
	        long waited = 0L;
	        long step = 1000L;
	        
	        while (waited < timeout) {
	        	QueueItem queueItem = jenkins.getQueueItem(queueRef);
	            if (queueItem != null && queueItem.getExecutable() != null) {
	                return queueItem.getExecutable().getNumber();
	            }
	            if (queueItem != null && queueItem.isCancelled()) {
	                return -2L; // 취소됨
	            }

	            Thread.sleep(step);
	            waited += step;
	        }

	        return -3L;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return -1L;
	    }
	}
	
	
	public List<String> getLatestBuild(String projectName) {
		System.out.println("new buildnew buildnew buildnew buildnew build");
		List<String> infos = new ArrayList<>();
		try {
			JenkinsServer jenkins = getJenkinsServer();
			JobWithDetails job = jenkins.getJob("test1");
			
			Build lastBuild = job.getLastBuild();
            BuildResult result = lastBuild.details().getResult();
            
            infos.add(result != null ? result.name() : "BUILDING");
            infos.add(lastBuild.getNumber()+"");
            return infos;
            
		} catch (Exception e) {
			e.printStackTrace();
		}
		infos.add("ERROR");
		infos.add("-1");
		return infos;
	}
	
	public List<Integer> getSuccessRate(String projectName){
		String jenkinsUrl = "http://localhost:9000/job/test1/api/json?tree=builds[number,result]";
		List<Integer> data = new ArrayList<>();
		
		try {
			
	        URL url = new URL(jenkinsUrl);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");

	        
	        String auth = user + ":" + token;
	        String encodedAuth = Base64.getEncoder().encodeToString(auth.getBytes());
	        conn.setRequestProperty("Authorization", "Basic " + encodedAuth);
	        
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
	        StringBuilder response = new StringBuilder();
	        String line;
	        while ((line = br.readLine()) != null) {
	            response.append(line);
	        }
	        br.close();

	        
	        JSONObject json = new JSONObject(response.toString());
	        JSONArray builds = json.getJSONArray("builds");

	        int total = builds.length();
	        int successCount = 0;

	        for (int i = 0; i < total; i++) {
	            JSONObject build = builds.getJSONObject(i);
	            String result = build.optString("result", "UNKNOWN");
	            if ("SUCCESS".equals(result)) {
	                successCount++;
	            }
	        }
	        //System.out.println("**********successCount: "+successCount);
	        //System.out.println("**********total: "+total);
	        int successRate = (int)(((double)successCount/total) * 100);
	        //System.out.println("**********successRate: "+successRate);
	        int failRate = 100 - successRate;
			data.add(successRate);
			data.add(failRate);
		}catch(Exception e) {
			System.out.println("error occurred");
		}
		
		
		return data;
	}
	
	@Async
	public void streamLogs(String projectName, Integer buildNum, SseEmitter emitter) {
        
		String jobName = "test1";
        long pos = 0;
        boolean buildIsRunning = true;
        HttpURLConnection conn = null;

        try {
            String auth = user + ":" + token;
            String encodedAuth = Base64.getEncoder().encodeToString(auth.getBytes());
            String authHeader = "Basic " + encodedAuth;

            emitter.send(SseEmitter.event().name("connect").data("Log stream started..."));

            while (buildIsRunning) {
                String apiUrl = String.format("%s/job/%s/%d/logText/progressiveText?start=%d",
                                            jenkinsUrl, jobName, buildNum, pos);
                URL url = new URL(apiUrl);
                
                conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                conn.setRequestProperty("Authorization", authHeader);
                conn.setUseCaches(false);
                
                int statusCode = conn.getResponseCode();
                if (statusCode != 200) {
                    throw new RuntimeException("Log stream failed, status: " + statusCode);
                }

                //logchunck 읽기
                StringBuilder logChunkBuilder = new StringBuilder();
                try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
                    String line;
                    while ((line = br.readLine()) != null) {
                    	
                        logChunkBuilder.append(line).append("\n\n"); //
                    }
                }
                String logChunk = logChunkBuilder.toString();
                
                //헤더 읽기
                String textSize = conn.getHeaderField("X-Text-Size");
                if (textSize != null) {
                    pos = Long.parseLong(textSize);
                }

                // emitter로 데이터 전송
                if (logChunk != null && !logChunk.isEmpty()) {
                	//System.out.println(logChunk);
                    emitter.send(SseEmitter.event().name("log").data(logChunk, TEXT_UTF8));
                }

                // 종료 헤더 읽기
                String moreData = conn.getHeaderField("X-More-Data");
                if (moreData == null || !"true".equals(moreData)) {
                    
                    buildIsRunning = false; 
                }
                
                conn.disconnect();
                
                if (buildIsRunning) {
                    Thread.sleep(200); //
                }
            }

            emitter.send(SseEmitter.event().name("complete").data("Build finished."));
            emitter.complete();

        } catch (Exception e) {
            try {
                emitter.send(SseEmitter.event().name("error").data(e.getMessage()));
            } catch (IOException ioEx) {
            }
            emitter.completeWithError(e);
        } finally {
            if (conn != null) {
                conn.disconnect(); 
            }
        }
	}

}
