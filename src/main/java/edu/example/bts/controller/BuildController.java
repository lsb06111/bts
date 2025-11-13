package edu.example.bts.controller;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import edu.example.bts.domain.history.RequestsDTO;
import edu.example.bts.domain.project.DevRepoDTO;
import edu.example.bts.domain.user.UserDTO;
import edu.example.bts.service.BuildService;
import edu.example.bts.service.DeployRequestHistoryService;
import edu.example.bts.service.JenkinsService;

@Controller
@RequestMapping("build")
public class BuildController {
	
	@Autowired
	BuildService buildService;
	
	@Autowired
	DeployRequestHistoryService historyService;
	
	@Autowired
	JenkinsService jenkinsService;

	@RequestMapping("")
	public String goBuild(@RequestAttribute("loginUser") UserDTO user,
						  @RequestParam(value="buildStatus", required=false) String buildStatus,
						  @RequestParam(value="page", required=false) Integer page,
						  @RequestParam(value="keyword", required=false) String keyword,
						  @RequestParam(value="filter", required=false) String filter,
						  Model model) {
		

		System.out.println("build build filter: "+filter);
		System.out.println("build build filter: "+keyword);
		boolean isCombined = false;
		if(filter != null)
			isCombined = filter.contains("+");
		
		List<RequestsDTO> requests = buildService.getRequestsForBuild(user, page-1, buildStatus, keyword, filter, isCombined);
		int totalCount = buildService.getRequestsSizeForBuild(user, buildStatus, keyword, filter, isCombined);
		
		int totalPage = (int) Math.ceil((double) totalCount / 10);
		
		
		model.addAttribute("page", page);
		model.addAttribute("requests", requests);
		model.addAttribute("totalPage", totalPage);
		return "build/buildList";
	}
	
	@ResponseBody
	@PostMapping("doBuild")
	public Map<String, Object> doBuild(@RequestParam List<Long> reqIds){

		System.out.println("hehehehhehehhe");
		Map<String, Object> map = new HashMap<>();
		if(buildService.addDeployResults(reqIds)){
			//String buildResult = jenkinsService.triggerBuildNow("test1");
			//System.out.println(buildResult);
			// add buildNum
			map.put("buildNum", jenkinsService.triggerBuildNow("test1"));
			return map;
		}
		map.put("buildNum", -1);
		return map;
	}
	
	@ResponseBody
	@GetMapping(value="getBuildLog", produces="text/event-stream; charset=UTF-8")
	public SseEmitter getBuildLog(@RequestParam String projectName,
								  @RequestParam Integer buildNum,
								  @RequestParam List<Long> reqIds,
								  HttpServletResponse res){
		res.setCharacterEncoding("UTF-8");
		res.setHeader("Content-Type", "text/event-stream; charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		SseEmitter emitter = new SseEmitter(1800000L);
		
		jenkinsService.streamLogs(projectName, buildNum, emitter, reqIds);
		
		return emitter;
	}
	
	@ResponseBody
	@GetMapping("updateBuildResult")
	public ResponseEntity<String> updateBuildResult(@RequestParam List<Long> reqIds, @RequestParam String resultType){
		LocalDateTime now = LocalDateTime.now();
		for(Long reqId : reqIds) {
			if(!buildService.updateDeployResult(reqId, resultType, now))
				return new ResponseEntity<>("업데이트 실패", HttpStatus.CONFLICT);
		}
		return new ResponseEntity<>("업데이트 성공", HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping("makeRebuild")
	public ResponseEntity<String> makeRebuild(@RequestParam Long reqId){
		if(buildService.updateDeployResult(reqId, "ready", null))
			return new ResponseEntity<>("업데이트 성공", HttpStatus.OK);
		return new ResponseEntity<>("업데이트 실패", HttpStatus.CONFLICT);
	}
	
	
	
}
