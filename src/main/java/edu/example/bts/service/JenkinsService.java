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
	
	public List<Integer> getSuccessRate(String projectName){
		String jenkinsUrl = "http://localhost:9000/job/test1/api/json?tree=builds[number,result]";
		List<Integer> data = new ArrayList<>();
		
		try {
			// 1. URL 연결 설정
	        URL url = new URL(jenkinsUrl);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");

	        // 2. 인증 헤더 추가 (Basic Auth)
	        String auth = user + ":" + token;
	        String encodedAuth = Base64.getEncoder().encodeToString(auth.getBytes());
	        conn.setRequestProperty("Authorization", "Basic " + encodedAuth);

	        // 3. 응답 읽기
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
	        StringBuilder response = new StringBuilder();
	        String line;
	        while ((line = br.readLine()) != null) {
	            response.append(line);
	        }
	        br.close();

	        // 4. JSON 파싱
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
	        System.out.println("**********successCount: "+successCount);
	        System.out.println("**********total: "+total);
	        int successRate = (int)(((double)successCount/total) * 100);
	        System.out.println("**********successRate: "+successRate);
	        int failRate = 100 - successRate;
			data.add(successRate);
			data.add(failRate);
		}catch(Exception e) {
			System.out.println("error occurred");
		}
		
		
		return data;
	}
}
