package edu.example.bts.controller;

import java.util.ArrayList;
import java.util.List;

import org.kohsuke.github.GHCommit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.example.bts.domain.deployRequest.CommitDTO;
import edu.example.bts.domain.deployRequest.CommitFileDTO;
import edu.example.bts.service.DeployRequestGithubAPIService;

@Controller
public class DeployRequestController {

	@Autowired
	DeployRequestGithubAPIService deployGithubService;
	
	String ownerName = "rwanda95do";
	String repoName = "vote-and-voice";
	String token = "";	// 깃토큰

	@GetMapping("/deployRequest")
	public String deployRequest(Model model) {
		//Github repo의 commitList 가져오기
		List<CommitDTO> commitList = deployGithubService.getCommitList(ownerName, repoName, token);
		
		model.addAttribute("commitList", commitList);
		return "/deploy/deployRequest";
	}
	
	
	
	@GetMapping(value = "/deployRequest/commits/sha", produces="application/json; charset=UTF-8")
	@ResponseBody
	public List<CommitFileDTO> getCommitFileName(@RequestParam String sha) {
		System.out.println(sha);
		List<CommitFileDTO> fileList = deployGithubService.getCommitDetail(ownerName, repoName, token, sha);
		return fileList;
	}
	
	
// 같은 파일의 커밋 목록(sha)가져오기 
	@GetMapping(value="/deployRequest/commit/queryCommit/fileName", produces="application/json; charset=UTF-8")
	@ResponseBody
	public List<String> getFileCommitList(@RequestParam String fileName){
		List<String> fileShaList = deployGithubService.getFileCommitList(ownerName, repoName, token, fileName);
		return fileShaList;
	}
	
// 같은 파일 커밋으로 비교하기 : 모달.select.과거SHA
	@GetMapping(value="/deployRequest/commit/compare/basehead", produces="application/json; charset=UTF-8")
	@ResponseBody
	public String compareFileWithCommitSha(@RequestParam String fileName, @RequestParam String sha, @RequestParam String compareSha) {
		String diffPatch = deployGithubService.compareFileWithCommitSha(ownerName, repoName, token, fileName, sha, compareSha);
		return diffPatch;
	}
	
	
	
	
}
