package edu.example.bts.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
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
						  @RequestParam(value="project", required=false) String projectName,
						  @RequestParam(value="page", required=false) Integer page,
						  @RequestParam(value="keyword", required=false) String keyword,
						  Model model) {
		
		List<RequestsDTO> requests = buildService.getRequestsForBuild(user, page-1, projectName, keyword);
		int totalCount = buildService.getRequestsSizeForBuild(user, page-1, projectName, keyword);
		
		int totalPage = (int) Math.ceil((double) totalCount / 10);
		
		List<DevRepoDTO> projectList = historyService.getAllProjectForS(user.getId());
		model.addAttribute("page", page);
		model.addAttribute("requests", requests);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("userDetails", historyService.getUsersByReq(requests));
		model.addAttribute("projectList", projectList);
		return "build/buildList";
	}
	
	@ResponseBody
	@PostMapping("doBuild")
	public Map<String, Object> doBuild(@RequestParam List<Long> reqIds){

		System.out.println("hehehehhehehhe");
		Map<String, Object> map = new HashMap<>();
		if(buildService.addDeployResult(reqIds)){
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
								  HttpServletResponse res){
		res.setCharacterEncoding("UTF-8");
		res.setHeader("Content-Type", "text/event-stream; charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		SseEmitter emitter = new SseEmitter(1800000L);
		
		jenkinsService.streamLogs(projectName, buildNum, emitter);
		
		return emitter;
	}
	
	
}
