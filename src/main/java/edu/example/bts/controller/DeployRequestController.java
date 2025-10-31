package edu.example.bts.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
import edu.example.bts.domain.deployRequest.DeployFormDevRepoDTO;
import edu.example.bts.service.DeployFormService;
import edu.example.bts.service.DeployRequestGithubAPIService;

@Controller
public class DeployRequestController {

	@Autowired
	DeployRequestGithubAPIService deployGithubService;  // GitAPI관련
	@Autowired
	DeployFormService deployFormService;  // deploy-DB 관련 


	/* : model로 페이지 이동했을때 
	@GetMapping("/deployRequest")
	public String deployRequest(Model model) {
		//Github repo의 commitList 가져오기
		List<CommitDTO> commitList = deployGithubService.getCommitList(ownerName, repoName, token);
		
		model.addAttribute("commitList", commitList);
		return "/deploy/deployRequest";
	}*/
	
	/*: Ajax로 data에 Git관련 정보(ownerName, repoName, token) 
	@GetMapping("/deployRequest")
	@ResponseBody
	public List<CommitDTO> deployRequest(Model model, @RequestParam String ownerName, @RequestParam String repoName, @RequestParam String token) {
		//Github repo의 commitList 가져오기
		List<CommitDTO> commitList = deployGithubService.getCommitList(ownerName, repoName, token);

		System.out.println(commitList);
		//model.addAttribute("commitList", commitList);
		return commitList;
	}
	*/ 
	/* : Ajax data 선택된 devRepo의 id */
	@GetMapping("/deployRequest")
	@ResponseBody
	public List<CommitDTO> deployRequest(Model model,@RequestParam("repoId") Long repoId, HttpSession session) {
		// devRepo 정보 가져오기 
		DeployFormDevRepoDTO devRepoDTO = deployFormService.findDevRepoById(repoId);   // 그냥 처음부터 다 가져올수 없는건가?
		String ownerName = devRepoDTO.getOwnerUsername();
		String repoName = devRepoDTO.getRepoName();
		String token=devRepoDTO.getRepoToken();
		
		// session에 넣어서  여러번 DB안가고 사용할 수 있을까?
		session.setAttribute("ownerName", ownerName);
		session.setAttribute("repoName", repoName);
		session.setAttribute("token", token);
	
		
		//Github repo의 commitList 가져오기
		List<CommitDTO> commitList = deployGithubService.getCommitList(ownerName, repoName, token);
		
		System.out.println(commitList);
		//model.addAttribute("commitList", commitList);
		return commitList;
	}
		

	
	@GetMapping(value = "/deployRequest/commits/sha", produces="application/json; charset=UTF-8")
	@ResponseBody
	public List<CommitFileDTO> getCommitFileName(@RequestParam String sha, HttpSession session) {
		//System.out.println(sha);
		//System.out.println(session.getAttribute("ownerName"));
		List<CommitFileDTO> fileList = deployGithubService.getCommitDetail((String)session.getAttribute("ownerName"), (String)session.getAttribute("repoName"), (String)session.getAttribute("token"), sha);
		return fileList;
	}
	
	
// 같은 파일의 커밋 목록(sha)가져오기 
	@GetMapping(value="/deployRequest/commit/queryCommit/fileName", produces="application/json; charset=UTF-8")
	@ResponseBody
	public List<String> getFileCommitList(@RequestParam String fileName, HttpSession session){
		List<String> fileShaList = deployGithubService.getFileCommitList((String)session.getAttribute("ownerName"), (String)session.getAttribute("repoName"), (String)session.getAttribute("token"), fileName);
	
		return fileShaList;
	}
	
// 같은 파일 커밋으로 비교하기 (GitHubApi): 모달2.select.과거SHA
	@GetMapping(value="/deployRequest/commit/compare/basehead", produces="application/json; charset=UTF-8")
	@ResponseBody
	public String compareFileWithCommitSha(@RequestParam String fileName, @RequestParam String sha, @RequestParam String compareSha, HttpSession session) {
		String diffPatch = deployGithubService.compareFileWithCommitSha((String)session.getAttribute("ownerName"), (String)session.getAttribute("repoName"), (String)session.getAttribute("token"), fileName, sha, compareSha);
		//System.out.println(diffPatch);
		return diffPatch;
	}
	
// 같은 파일 커밋으로 비교 (java-diff-utils) : 모달3(줄맞춤 안됨)
	@GetMapping(value="/deployRequest/commit/compare/basehead3", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> compareFileWithCommitSha3(@RequestParam String fileName, @RequestParam String sha, @RequestParam String compareSha, HttpSession session) {
		Map<String, Object> diffPatch = deployGithubService.compareFileWithCommitSha3((String)session.getAttribute("ownerName"), (String)session.getAttribute("repoName"), (String)session.getAttribute("token"), fileName, sha, compareSha);
		//System.out.println(diffPatch);
		return diffPatch;
	}
	
// 같은 파일 커밋으로 비교 (java-diff-utils) : 모달4
	@GetMapping(value="/deployRequest/commit/compare/basehead4", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> compareFileWithCommitSha4(@RequestParam String fileName, @RequestParam String sha, @RequestParam String compareSha, HttpSession session) {
		Map<String, Object> diffPatch = deployGithubService.compareFileWithCommitSha4((String)session.getAttribute("ownerName"), (String)session.getAttribute("repoName"), (String)session.getAttribute("token"), fileName, sha, compareSha);
		//System.out.println(diffPatch);
		return diffPatch;
	}

	
	
	
}
