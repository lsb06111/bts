package edu.example.bts.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.example.bts.domain.jenkins.JCommitDTO;
import edu.example.bts.service.JenkinsService;

@Controller
@RequestMapping("jenkins")
public class JenkinsController {

	@Autowired
	JenkinsService jenkinsService;
	
	@ResponseBody
	@GetMapping(value = "getCommits", produces = "application/json; charset=UTF-8")
	public List<JCommitDTO> getCommits(){
		return jenkinsService.getCommitList();
	}
	
	@ResponseBody
	@GetMapping(value="getSuccessRate", produces="application/json; charset=UTF-8")
	public List<Integer> getSuccessRate(@RequestParam String projectName){
		return jenkinsService.getSuccessRate(projectName);
	}
	
	@ResponseBody
	@GetMapping(value="getLatestBuild", produces="application/json; charset=UTF-8")
	public Map<String, String> getLatestBuild(@RequestParam String projectName) {
		
		Map<String, String> map = new HashMap<>();
		map.put("result", jenkinsService.getLatestBuild(projectName));
		return map;
	}
}
