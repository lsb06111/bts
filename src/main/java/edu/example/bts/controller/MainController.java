package edu.example.bts.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import edu.example.bts.domain.history.RequestsDTO;
import edu.example.bts.domain.user.UserDTO;
import edu.example.bts.service.DeployRequestHistoryService;
import edu.example.bts.service.MainService;

@Controller
public class MainController {

	@Autowired
	MainService service;
	@Autowired
	DeployRequestHistoryService historyService;
	
	@RequestMapping("/")
	public String goMain(@RequestAttribute("loginUser") UserDTO user, Model model) {
		
		List<RequestsDTO> latestRequests = getLatestRequests(user);
		
		if(latestRequests != null) {
			model.addAttribute("latests", historyService.getLatestApproval(latestRequests));
			model.addAttribute("userDetails", historyService.getUsersByReq(latestRequests));
		}
		model.addAttribute("latestRequests", latestRequests);
		return "index";
	}
	
	public List<RequestsDTO> getLatestRequests(UserDTO user){
		List<RequestsDTO> latestRequests = null;
		System.out.println(user.getDept().getDeptno().intValue());
		switch(user.getDept().getDeptno().intValue()) {
			case 1: // dev team
				if(user.getJob().getJobno().intValue() == 2) // 사원
					latestRequests = service.getLatestRequestsForS(user.getId());
				else
					latestRequests = service.getLatestRequestsForT(user.getId());
				break;
			case 2: // 운영
				latestRequests = service.getLatestRequestsForU(user.getId());
				break;
		}
		
		return latestRequests;
	}
}
