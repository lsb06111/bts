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
import org.springframework.web.bind.annotation.RequestParam;

import edu.example.bts.domain.deployRequest.ApprovalHistoryDetailDTO;
import edu.example.bts.domain.deployRequest.DeployFormDevRepoDTO;
import edu.example.bts.domain.deployRequest.DeployRequestFormDTO;
import edu.example.bts.domain.deployRequest.DeployRequestsDTO;
import edu.example.bts.domain.deployRequest.RequestCommitFileDTO;
import edu.example.bts.domain.history.ApprovalHistoryDTO;
import edu.example.bts.domain.history.RequestsDTO;
import edu.example.bts.domain.user.UserDTO;
import edu.example.bts.service.DeployFormService;
import edu.example.bts.service.DeployRequestHistoryService;
import edu.example.bts.service.DeployRequestReportService;
import edu.example.bts.service.sse.NotifyService;

@Controller
public class DeployRequestReportController {

	@Autowired
	DeployRequestReportService requestReportService;
	
	@Autowired
	DeployRequestHistoryService deployRequestHistoryService;
	
	@Autowired
	DeployFormService deployFormService;
	
	@Autowired
	NotifyService notifyService;
	
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
		boolean isMine = user.getId()== userId ? true : false;
		
		
		// 승인/반려 사유
		List<ApprovalHistoryDetailDTO> approvalHistory =requestReportService.getApprovalHistoryDetailList(requestId);
		System.out.println(approvalHistory);
		
		// 결재라인정보
		List<String> approvlaLines = requestReportService.getApprovalLinesByDevRepoId(requestId);
		System.out.println("결재자 : " + approvlaLines);
		// 결재 단계 확인
		List<ApprovalHistoryDTO> approvals = requestReportService.getApprovalHistoryByReqId(requestId);
		String result = deployRequestHistoryService.getTotalStep(approvals).charAt(0)+"";
		System.out.println("누가 결재 해야하냐????? : " + result);
		
		
		
		
		model.addAttribute("requestsDTO", requestsDTO);
		model.addAttribute("commitFilesList", commitFilesList);
		
		model.addAttribute("isMine", isMine);
		model.addAttribute("latests", latests);  // 대기중, 승인요망..
		model.addAttribute("jobNo", user.getJob().getJobno());  // 다른 직원(사원)의 배포신청을 보게 되야한다면 필요

		model.addAttribute("approvalHistory", approvalHistory);
		
		model.addAttribute("approvlaLines", approvlaLines);
		model.addAttribute("result", result);
		
		return "/deploy/deployRequestReportView";
	}
	
	@PostMapping("/deploy/approval/submit")
	public String submitDeployApproval(@RequestAttribute("loginUser") UserDTO user, @RequestParam String content, @RequestParam Long reportId, @RequestParam String actionType) {
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
		Map<String, Object> notiPayload = new HashMap<>();
		DeployRequestsDTO deployRequestsDTO = deployRequestHistoryService.getRequestsById(reportId);
		String title = deployRequestsDTO.getTitle();
		Long reqId = deployRequestsDTO.getId();
		notiPayload.put("title", title);
		notiPayload.put("reqId", reqId);
		Long userId;
		if(statusId == 3)
			userId = notifyService.getPreviousApprovalLine(deployRequestsDTO.getDevRepoId(), user.getId(), deployRequestsDTO.getUserId());
		else
			userId = notifyService.getNextApprovalLine(deployRequestsDTO.getDevRepoId(), user.getId(), deployRequestsDTO.getUserId());
		
		notifyService.notifyUser(userId, notiPayload);
		deployRequestHistoryService.addNotification(title, ""+reqId, userId);
		
		
		return "redirect:/history?project=&status=&page=1";
	}
	
	@GetMapping("/deploy/approval/modify")
	public String modifyDeployReport(@RequestParam Long requestId, Model model, HttpSession session) {
		System.out.println("신청번호 : " + requestId);
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
		
		//
		List<DeployFormDevRepoDTO> devRepoByUserIdList = deployFormService.findProjectsByUserId(requestsDTO.getUserId());
		
		model.addAttribute("requestsDTO", requestsDTO);
		model.addAttribute("commitFilesList", commitFilesList);
		
		model.addAttribute("devRepoByUserIdList", devRepoByUserIdList);
		
		return "/deploy/deployReportModifyForm";
	}
	
	@PostMapping("/deployForm/sumbmitmodifyRequestForm")
	public String sumbmitModifyRequestForm (@RequestAttribute("loginUser") UserDTO user, DeployRequestFormDTO deployRequestFormDTO, HttpSession session) {
		// 작성자만 수정하니까.. 로그인 유저로 넘겨도 되겟지..?
		deployRequestFormDTO.setUserId(user.getId());
		System.out.println("저기요????   : " + deployRequestFormDTO);
		
		// 수정
		requestReportService.modifyRequestForm(deployRequestFormDTO);
		
		//modify sse
		Map<String, Object> notiPayload = new HashMap<>();
		String title = deployRequestFormDTO.getTitle();
		Long reqId = deployRequestFormDTO.getReqId();
		notiPayload.put("title", title);
		notiPayload.put("reqId", reqId);
		Long userId = notifyService.getNextApprovalLine(deployRequestFormDTO.getDevRepoId(), user.getId(), deployRequestFormDTO.getUserId());
		
		notifyService.notifyUser(userId, notiPayload);
		deployRequestHistoryService.addNotification(title, ""+reqId, userId);
		
		return "redirect:/";
	}
}
