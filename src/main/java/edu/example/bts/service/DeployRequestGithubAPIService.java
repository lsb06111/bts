package edu.example.bts.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;

import edu.example.bts.dao.DeployRequestDAO;
import edu.example.bts.domain.deployRequest.CommitDTO;

@Service
public class DeployRequestGithubAPIService {

	// Github API 헤더 (공통) 
	
	@Autowired
	private DeployRequestDAO dao;
	
	//Github repo의 commitList 가져오기
	public List<CommitDTO> getCommitList(String ownerName, String repoName, String token) {
		String url = "https://api.github.com/repos/"+ ownerName +"/"+ repoName + "/commits";
		
		HttpHeaders headers = new HttpHeaders();
		headers.set("Accept", "application/vnd.github+json");
		headers.setBearerAuth(token);		// headers.set("Authorization", "Bearer " + token);
		headers.set("X-GitHub-Api-Version", "2022-11-28");
		
		HttpEntity<Void> request = new HttpEntity<>(headers);	// 요청
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<JsonNode> response = restTemplate.exchange(url, HttpMethod.GET, request, JsonNode.class); // 응답
	
		List<CommitDTO> commitList = new ArrayList<CommitDTO>();
		
		if(response.getStatusCode() == HttpStatus.OK) {
			JsonNode items = response.getBody();
			for(JsonNode item : items) {
				CommitDTO commitDto = new CommitDTO();
				
				commitDto.setSha(item.get("sha").asText());
				commitDto.setCommitMessage(item.get("commit").get("message").asText());
				commitDto.setAuthorName(item.get("commit").get("author").get("name").asText());
				commitDto.setAuthorDate(item.get("commit").get("author").get("date").asText());
				
				// GIT-ID에 맞춰서 사람 이름 가져오기 
				String empUserName = dao.findEmpNameByGitId(item.get("commit").get("author").get("name").asText());
				commitDto.setUserName(empUserName);
				
				//System.out.println(commitDto.toString());
				commitList.add(commitDto);
			}
		}
		//System.out.println(commitList.size());
		return commitList;
	}

}
