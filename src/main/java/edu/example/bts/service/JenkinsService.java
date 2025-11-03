package edu.example.bts.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.example.bts.dao.JenkinsDAO;
import edu.example.bts.domain.jenkins.JCommitDTO;

@Service
public class JenkinsService {

	@Autowired
	JenkinsDAO jenkinsDAO;
	
	String user = "test1";
	String token = "qwer1234"; // token & password 둘다 가능
	
	public List<JCommitDTO> getCommitList(){
		return jenkinsDAO.getCommitList();
	}
	
	
	public List<JCommitDTO> getCommitFiles(){
		List<Long> reqIds = jenkinsDAO.getAwaitedReqIds();
		List<JCommitDTO> commits = new ArrayList<>();
		for(Long reqId : reqIds) {
			commits.addAll(jenkinsDAO.getCommitListByReqId(reqId));
			jenkinsDAO.updateResult(reqId);
		}
		
		
		return commits;
	}
	
	public String triggerBuildNow(String projectName) {
	    String base = "http://localhost:9000";
	    String crumbApi = base + "/crumbIssuer/api/json";
	    String buildApi = base + "/job/" + projectName + "/build";

	    try {
	        String auth = user + ":" + token;
	        String encodedAuth = Base64.getEncoder().encodeToString(auth.getBytes());

	        URL cUrl = new URL(crumbApi);
	        HttpURLConnection cConn = (HttpURLConnection) cUrl.openConnection();
	        cConn.setRequestMethod("GET");
	        cConn.setRequestProperty("Authorization", "Basic " + encodedAuth);
	        cConn.setUseCaches(false);
	        cConn.setInstanceFollowRedirects(false);

	        
	        String setCookie = cConn.getHeaderField("Set-Cookie"); 
	        String cookieHeader = null;
	        if (setCookie != null) {
	            
	            cookieHeader = setCookie.split(";", 2)[0];
	        }

	        StringBuilder csb = new StringBuilder();
	        try (BufferedReader br = new BufferedReader(new InputStreamReader(cConn.getInputStream(), "UTF-8"))) {
	            String line;
	            while ((line = br.readLine()) != null) csb.append(line);
	        } catch (Exception e) {

	        } finally {
	            cConn.disconnect();
	        }

	        String crumbField = null;
	        String crumbValue = null;
	        if (csb.length() > 0) {
	            JSONObject cj = new JSONObject(csb.toString());
	            crumbField = cj.optString("crumbRequestField", null);
	            crumbValue = cj.optString("crumb", null);
	        }

	        
	        URL bUrl = new URL(buildApi);
	        HttpURLConnection bConn = (HttpURLConnection) bUrl.openConnection();
	        bConn.setRequestMethod("POST");
	        bConn.setDoOutput(true);
	        bConn.setRequestProperty("Authorization", "Basic " + encodedAuth);

	        
	        if (cookieHeader != null) {
	            bConn.setRequestProperty("Cookie", cookieHeader);
	        }
	        
	        if (crumbField != null && crumbValue != null) {
	            bConn.setRequestProperty(crumbField, crumbValue);
	        }

	        int code = bConn.getResponseCode();
	        String location = bConn.getHeaderField("Location");
	        bConn.disconnect();

	        if (code == 201 && location != null) return "QUEUED: " + location;
	        return "ERROR: HTTP " + code;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return "ERROR";
	    }
	}
	
	public String getLatestBuild(String projectName) {
		String jenkinsUrl = "http://localhost:9000/job/test1/lastBuild/api/json?pretty=true";
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
	        return json.optString("result", "UNKNOWN");
	        
		}catch(Exception e) {
			System.out.println("error");
		}
		
		return "ERROR";
		
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
}
