package edu.example.bts.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;

import edu.example.bts.domain.deployRequest.DeployFormDevRepoDTO;
import edu.example.bts.domain.deployRequest.DeployRequestFormDTO;
import edu.example.bts.domain.deployRequest.DeployRequestsDTO;
import edu.example.bts.domain.history.NotificationDTO;
import edu.example.bts.domain.user.UserDTO;
import edu.example.bts.service.DeployFormService;
import edu.example.bts.service.DeployRequestHistoryService;
import edu.example.bts.service.sse.NotifyService;

@Controller
public class DeployFormController {

	@Autowired
	DeployFormService deployFormService;
	
	@Autowired
	NotifyService notifyService;
	
	@Autowired
	DeployRequestHistoryService historyService;
	
	
	@GetMapping("/deployForm")
	public String deployForm(@RequestAttribute("loginUser") UserDTO user, Model model, HttpSession session) {
		Long userId = user.getId();
		// 사용자가 속한 진행중인 프로젝트 찾기
		List<DeployFormDevRepoDTO> devRepoByUserIdList = deployFormService.findProjectsByUserId(userId);
		
		model.addAttribute("devRepoByUserIdList", devRepoByUserIdList);
		//return "/deploy/deployForm";
		return "/deploy/deployRequestForm";
	}
	
	/*@PostMapping("/deployForm/sumbmitDeployForm")
	public String showDeployRequestPage(@RequestAttribute("loginUser") UserDTO user, DeployRequestsDTO deployRequestsDTO, Model model ) {
	
		deployRequestsDTO.setUserId(user.getId());
		
		if(deployFormService.createRequests(deployRequestsDTO)) {
			System.out.println(deployRequestsDTO.getId());
		}
		model.addAttribute("deployRequestsDTO", deployRequestsDTO);
		
		return "redirect:/deployRequest";
	}*/
	
	@PostMapping("/deployForm/sumbmitDeployRequestForm")
	public String sumbmitDeployRequestForm(@RequestAttribute("loginUser") UserDTO user, DeployRequestFormDTO deployRequestFormDTO, HttpSession session) {
		System.out.println("제출함" + user.getId());
		System.out.println("제출함 : " + deployRequestFormDTO.toString());

		
		deployRequestFormDTO.setUserId(user.getId());
		
		DeployRequestsDTO deployRequestsDTO = deployFormService.createRequests(deployRequestFormDTO);
		
		// 에미터로 알림 보내기
		Map<String, Object> notiPayload = new HashMap<>();
		String title = deployRequestFormDTO.getTitle();
		Long reqId = deployRequestsDTO.getId();
		
		Long userId = notifyService.getNextApprovalLine(deployRequestFormDTO.getDevRepoId(), user.getId(), deployRequestFormDTO.getUserId());
		String slug = "/bts/deployRequestView?requestId="+reqId+"&userId="+deployRequestsDTO.getUserId()+"&latests=승인요망";
		
		NotificationDTO notificationDTO = new NotificationDTO();
		notificationDTO.setTitle(title);
		notificationDTO.setSlug(slug);
		notificationDTO.setUserId(userId);
		notificationDTO.setFromUserId(user.getId());
		notificationDTO.setMessage(slug.split("latests")[1].substring(1));
		historyService.addNotification(notificationDTO);
		notiPayload.put("notification", notificationDTO);
		notifyService.notifyUser(userId, notiPayload);
		
		
		// git저장한 세션 제거?
		session.removeAttribute("ownerName");
		session.removeAttribute("repoName");
		session.removeAttribute("token");
		
		return "redirect:/"; //"redirect:/history?project=&status=&page=1";
	}
	
}
