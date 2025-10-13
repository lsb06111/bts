package edu.example.bts.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import edu.example.bts.domain.history.DevRepoDTO;
import edu.example.bts.domain.history.RequestsDTO;
import edu.example.bts.domain.user.UserDTO;
import edu.example.bts.service.DeployRequestHistoryService;

@Controller
public class DeployRequestHistoryController {

	@Autowired
	DeployRequestHistoryService service;
	
	@RequestMapping("history")
	public String goHistory(@SessionAttribute("user") UserDTO user,
							Model model) {
		Long userId = user.getId();
		List<RequestsDTO> requests = service.getAllRequestsForS(userId);
		List<DevRepoDTO> projectList = service.getAllProjectForS(userId);
		
		model.addAttribute("requests", requests);
		model.addAttribute("latests", service.getLatestApproval(requests));
		model.addAttribute("userDetails", service.getUsersByReq(requests));
		model.addAttribute("statusList", service.getAllStatus());
		model.addAttribute("projectList", projectList);
		return "deployRequestHistory";
	}
}
