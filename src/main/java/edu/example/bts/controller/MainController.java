package edu.example.bts.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.example.bts.domain.history.NotificationDTO;
import edu.example.bts.domain.history.RequestsDTO;
import edu.example.bts.domain.user.UserDTO;
import edu.example.bts.service.DeployRequestHistoryService;
import edu.example.bts.service.MainService;

@Controller
public class MainController {

	@Autowired
	MainService mainService;
	@Autowired
	DeployRequestHistoryService historyService;
	
	@RequestMapping("/")
	public String goMain(@RequestAttribute("loginUser") UserDTO user, Model model) {
		
		List<RequestsDTO> latestRequests = getLatestRequests(user);
		//만약 인사팀이라면
		if(user.getDept().getDeptno() == 3) {
			model.addAttribute("qnaList", historyService.getLatestQnaList());
		}else {
			if(latestRequests != null) {
				model.addAttribute("statusT", historyService.getStatus(latestRequests, user));
				model.addAttribute("userDetails", historyService.getUsersByReq(latestRequests));
			}
		}
		
		
		model.addAttribute("latestRequests", latestRequests);
		model.addAttribute("latestNotice", mainService.getLatestNotice());
		return "index";
	}
	
	public List<RequestsDTO> getLatestRequests(UserDTO user){
		List<RequestsDTO> latestRequests = null;
		System.out.println(user.getDept().getDeptno().intValue());
		switch(user.getDept().getDeptno().intValue()) {
			case 1: // dev team
				if(user.getJob().getJobno().intValue() == 2) // 사원
					latestRequests = historyService.getRequestsForS(user.getId());
				else
					latestRequests = historyService.getRequestsForT(user.getId(), 1);
				break;
			case 2: // 운영
				latestRequests = historyService.getRequestsForT(user.getId(), 2);
				break;
		}
		
		return latestRequests;
	}
	
	@ResponseBody
	@PostMapping("auth/updateInfo")
	public ResponseEntity<String> updateInfo(UserDTO userDTO){
		if(mainService.updateInfo(userDTO))
			return new ResponseEntity<>("정보수정 성공", HttpStatus.OK);
		
		return new ResponseEntity<>("정보수정 실패", HttpStatus.CONFLICT);
	}
	
	@ResponseBody
	@GetMapping("getNotifications")
	public List<NotificationDTO> getNotifications(Long userId){
		return historyService.getNotificationsByUserId(userId);
	}
}
