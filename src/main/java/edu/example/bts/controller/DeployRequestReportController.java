package edu.example.bts.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import edu.example.bts.domain.deployRequest.DeployFormDevRepoDTO;
import edu.example.bts.domain.deployRequest.DeployRequestsDTO;
import edu.example.bts.domain.deployRequest.RequestCommitFileDTO;
import edu.example.bts.domain.user.UserDTO;
import edu.example.bts.service.DeployRequestReportService;

@Controller
public class DeployRequestReportController {

	@Autowired
	DeployRequestReportService requestReportService;
	
	@GetMapping("/deployRequestView")
	public String deployRequestView(@RequestAttribute("loginUser") UserDTO user, @RequestParam Long requestId, @RequestParam Long userId,@RequestParam String latests, Model model, HttpSession session) {
		// 하나의 보고서 내용 가져오기
		DeployRequestsDTO requestsDTO = requestReportService.getRequestByReportId(requestId);
		System.out.println("하나의 보고서(requests): " + requestsDTO);
		// 보고서와 관련된 커밋 파일 목록들
		List<RequestCommitFileDTO> commitFilesList = requestReportService.getCommitFilesByReportId(requestId);
		System.out.println("보고서와 관련된 커밋 파일 목록 : " + commitFilesList);
		// 개발 레포 정보 가져오기 > 세션
		DeployFormDevRepoDTO devRepoDTO = requestReportService.getDevRepoById(requestsDTO.getDevRepoId());
		String ownerName = devRepoDTO.getOwnerUsername();
		String repoName = devRepoDTO.getRepoName();
		String token=devRepoDTO.getRepoToken();
		
		session.setAttribute("ownerName", ownerName);
		session.setAttribute("repoName", repoName);
		session.setAttribute("token", token);
	
		// 글 작성자인지 아닌지 확인  -> 따로 함수로 만들고 싶네?
		//System.out.println("로그인 한 사람입니다 : " +  user.getId());
		boolean isMine = user.getId()== userId ? true : false;
		//System.out.println(isMine);
		//System.out.println("잡NO???" + user.getJob().getJobno());
		
		
		model.addAttribute("requestsDTO", requestsDTO);
		model.addAttribute("commitFilesList", commitFilesList);
		
		model.addAttribute("isMine", isMine);
		model.addAttribute("latests", latests);  // 대기중, 승인요망..
		model.addAttribute("jobNo", user.getJob().getJobno());  // 다른 직원(사원)의 배포신청을 보게 되야한다면 필요

		
		return "/deploy/deployRequestReportView";
	}
	
	@PostMapping("/deploy/approval/submit")
	public String submitDeployApproval(@RequestParam String content, @RequestParam Long reportId, @RequestParam String actionType) {
		System.out.println("********************");
		System.out.println("content : " + content);
		System.out.println("reportId : " + reportId);
		System.out.println("actionType : " + actionType);

		long statusId =1;
		if(actionType.equals("승인")) {
			statusId=2;
		}else if(actionType.equals("반려")) {
			statusId=3;
		}
		requestReportService.insertApprovalHistory(reportId, statusId, content);
		
		
		
		return "redirect:/history?project=&status=&page=1";
	}
}
