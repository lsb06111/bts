package edu.example.bts.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.kohsuke.github.GHCommit;
import org.kohsuke.github.GHCommit.File;
import org.kohsuke.github.GHRepository;
import org.kohsuke.github.GitHub;
import org.kohsuke.github.GitHubBuilder;
import org.kohsuke.github.PagedIterable;
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
import edu.example.bts.domain.deployRequest.CommitFileDTO;

@Service
public class DeployRequestGithubAPIService {

	// Github API 헤더 (공통) 
	
	@Autowired
	private DeployRequestDAO dao;
	
	//Github repo의 commitList 가져오기
	public List<CommitDTO> getCommitList(String ownerName, String repoName, String token)  {
		/*
		String url = "https://api.github.com/repos/"+ ownerName +"/"+ repoName + "/commits";
		
		HttpHeaders headers = new HttpHeaders();
		headers.set("Accept", "application/vnd.github+json");
		headers.setBearerAuth(token);		// headers.set("Authorization", "Bearer " + token);
		headers.set("X-GitHub-Api-Version", "2022-11-28");
		
		HttpEntity<Void> request = new HttpEntity<>(headers);	// 요청
		RestTemplate restTemplate = new RestTemplate();
		*/
		List<CommitDTO> commitList = new ArrayList<CommitDTO>();

		try {
			GitHub github = new GitHubBuilder().withOAuthToken(token).build();
			GHRepository repository = github.getRepository(ownerName + "/" + repoName);
			PagedIterable<GHCommit> ghcommitList = repository.listCommits();
			
			int count= 0;
			for(GHCommit commit : ghcommitList) {
				Date date = commit.getCommitShortInfo().getAuthor().getDate();     //Date authorDate = commit.getCommitShortInfo().getAuthoredDate();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
				
				String sha = commit.getSHA1();
				String commitMessage = commit.getCommitShortInfo().getMessage();
				String authorName = commit.getCommitShortInfo().getAuthor().getName();    //String authorName = commit.getAuthor().getLogin();
				String authorDate = dateFormat.format(date);
				
				String userName = dao.findEmpNameByGitId(authorName);
				
				CommitDTO dto = new CommitDTO(sha, commitMessage, authorName, authorDate, userName);
				commitList.add(dto);

				if(++count>10) break;  // 10개만 출력중... DB쪽을 너무 많이 다녀오는데 생각좀;;; 
			}
			
		}catch(Exception e) {
			System.err.println("Github API 호출중 에러 발생 : " + e.getMessage() );
		}
		
		return commitList;
	}

	// 선택한 커밋에 해당하는 파일정보 가져오기
	public List<CommitFileDTO> getCommitDetail(String ownerName, String repoName, String token, String sha) {
		List<CommitFileDTO> fileList = new ArrayList<>();
		try {
			GitHub github = new GitHubBuilder().withOAuthToken(token).build();
			GHRepository repository = github.getRepository(ownerName + "/" + repoName);
			GHCommit commit = repository.getCommit(sha);
			List<GHCommit.File> commitFileList = commit.getFiles();
		
			for(File file : commitFileList) {
				String fileSha = file.getSha();
				String fileName = file.getFileName();
				int lineAdded = file.getLinesAdded();
				int lineDeleted = file.getLinesDeleted();
				String status = file.getStatus();
				String patch = file.getPatch();
				
				CommitFileDTO dto = new CommitFileDTO(fileSha, fileName, lineAdded, lineDeleted, status, patch);
				fileList.add(dto);
			}
			
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return fileList;
		
	}

}
