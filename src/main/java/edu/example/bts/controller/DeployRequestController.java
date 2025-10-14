package edu.example.bts.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import edu.example.bts.domain.deployRequest.CommitDTO;
import edu.example.bts.service.DeployRequestGithubAPIService;

@Controller
public class DeployRequestController {

	@Autowired
	DeployRequestGithubAPIService deployGithubService;
	
	@GetMapping("/deployRequest")
	public String deployRequest(Model modal) {
		String ownerName = "rwanda95do";
		String repoName = "vote-and-voice";
		String token = "   ";	// 깃토큰
		
		//Github repo의 commitList 가져오기
		List<CommitDTO> commitList = deployGithubService.getCommitList(ownerName, repoName, token);
		
		modal.addAttribute("commitList", commitList);
		
		return "/deploy/deployRequest";
	}
	

	
	
	
}
