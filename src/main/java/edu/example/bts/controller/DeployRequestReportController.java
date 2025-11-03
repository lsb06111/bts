package edu.example.bts.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import edu.example.bts.domain.deployRequest.DeployFormDevRepoDTO;
import edu.example.bts.domain.deployRequest.DeployRequestsDTO;
import edu.example.bts.domain.deployRequest.RequestCommitFileDTO;
import edu.example.bts.service.DeployRequestReportService;

@Controller
public class DeployRequestReportController {

	@Autowired
	DeployRequestReportService requestReportService;
	
	@GetMapping("/deployRequestView")
	public String deployRequestView(@RequestParam Long requestId, Model model, HttpSession session) {
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
	
		
		model.addAttribute("requestsDTO", requestsDTO);
		model.addAttribute("commitFilesList", commitFilesList);
		return "/deploy/deployRequestReportView";
	}
	
	
}
