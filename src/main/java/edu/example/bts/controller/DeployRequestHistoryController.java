package edu.example.bts.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import edu.example.bts.domain.history.RequestsDTO;
import edu.example.bts.domain.project.DevRepoDTO;
import edu.example.bts.domain.user.UserDTO;
import edu.example.bts.service.DeployRequestHistoryService;

@Controller
public class DeployRequestHistoryController {

	@Autowired
	DeployRequestHistoryService historyService;
	
	@RequestMapping("history")
	public String goHistory(@RequestAttribute("loginUser") UserDTO user,
							@RequestParam("page") Integer page,
							@RequestParam(value = "project", required=false) String projectName,
							@RequestParam(value = "status", required=false) String status,
							Model model) {
		
		Long userId = user.getId();
		List<RequestsDTO> requests = null; 
		List<DevRepoDTO> projectList = null;
		int totalPage = 0;
		
		if(user.getDept().getDeptno().intValue() == 1 && user.getJob().getJobno().intValue() == 2) {
			int totalCount = (status.isEmpty() && projectName.isEmpty())? 
					historyService.getRequestsCount(userId) : historyService.getReqSizeForS(user,status, projectName);
		    totalPage = (int) Math.ceil((double) totalCount / 10);
		    
		    requests = historyService.getRequestsByPageForS2(user, page-1, projectName, status);
		    
		}else {
			int totalCount = (status.isEmpty() && projectName.isEmpty())?
					historyService.getRequestsCountByProjects(userId) : historyService.getReqSizeForSU(user,status, projectName);
		    totalPage = (int) Math.ceil((double) totalCount / 10);
		    requests = historyService.getRequestsByPageForSU2(user, page-1, projectName, status);
		}
		
		
		
		
		projectList = historyService.getAllProjectForS(userId);
		model.addAttribute("requests", requests);
		model.addAttribute("latests", historyService.getStatus(requests, user));
		model.addAttribute("userDetails", historyService.getUsersByReq(requests));
		model.addAttribute("statusList", historyService.getAllStatus());
		model.addAttribute("projectList", projectList);
		model.addAttribute("page", page);
	    model.addAttribute("totalPage", totalPage);
		return "deployRequestHistory";
	}
}
