package edu.example.bts.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.example.bts.dao.DeployFormDAO;
import edu.example.bts.dao.DeployRequestReportDAO;
import edu.example.bts.domain.deployRequest.ApprovalHistoryDetailDTO;
import edu.example.bts.domain.deployRequest.DeployFormDevRepoDTO;
import edu.example.bts.domain.deployRequest.DeployRequestFormDTO;
import edu.example.bts.domain.deployRequest.DeployRequestFormDTO.FileDTO;
import edu.example.bts.domain.deployRequest.DeployRequestsDTO;
import edu.example.bts.domain.deployRequest.RequestCommitFileDTO;
import edu.example.bts.domain.history.ApprovalHistoryDTO;
import edu.example.bts.domain.history.ApprovalLineDTO;

@Service
public class DeployRequestReportService {

	@Autowired
	DeployRequestReportDAO deployRequestReportDAO;
	
	@Autowired
	DeployFormDAO deployFormDAO;
	
	public DeployRequestsDTO getRequestByReportId(Long requestId) {
		return deployRequestReportDAO.selectRequestByReportId(requestId);

	}

	public List<RequestCommitFileDTO> getCommitFilesByReportId(Long requestId) {
		return deployRequestReportDAO.selectCommitFilesByReportId(requestId);
	}

	public DeployFormDevRepoDTO getDevRepoById(Long devRepoId) {
		return deployRequestReportDAO.selectDevRepoById(devRepoId);
	}

	public void insertApprovalHistory(Long reportId, long statusId, String content) {
		deployRequestReportDAO.insertApprovalHistory(reportId, statusId, content);
		
	}

	public List<ApprovalHistoryDetailDTO> getApprovalHistoryDetailList(Long requestId) {
		return deployRequestReportDAO.findApprovalHistoryDetailList(requestId);
	}
	
//	public SomeDTO testtest(Long requestId) {
//
//		List<ApprovalHistoryDTO> ahList = deployRequestReportDAO.findAllApprovalHistoryByReqId(requestId);
//		List<ApprovalLineDTO> alList = deployRequestReportDAO.findApprovalLinesByReqId(requestId);
//		
//		
//		List<ApprovalHistoryDTO> aa = new ArrayList<>(); // empty list
//		for(ApprovalHistoryDTO ah : ahList) {
//			aa.add(ah);
//			int totalStep = getTotalStep(aa);
//			Long empno = alList.get(totalStep-1).getEmpno();
//			
//		}
//		
//		return someDTO;
//	}
	
	

	public List<ApprovalHistoryDTO> getApprovalHistoryByReqId(Long requestId) {
		return deployRequestReportDAO.findApprovalHistoryByReqId(requestId);
	}

	public List<String> getApprovalLinesByDevRepoId(Long reqId) {
		return deployRequestReportDAO.findApprovalLinesByDevRepoId(reqId);
	}

	public DeployRequestsDTO getRequestsById(Long requestId) {
		return deployRequestReportDAO.findRequestsById(requestId);
	}

	public void modifyRequestForm(DeployRequestFormDTO deployRequestFormDTO) {
		// requests 테이블 수정 - reqId
		deployRequestReportDAO.updateRequestById(deployRequestFormDTO);
		// commit_files 테이블 삭제 - reqId
		deployRequestReportDAO.deleteCommitFilesByReqId(deployRequestFormDTO.getReqId());
		// commit_files 테이블 입력
		for(FileDTO file : deployRequestFormDTO.getSelectedFiles()) {
			deployFormDAO.createCommitFile(file, deployRequestFormDTO.getReqId());			
		}
		// approval_history 입력
		deployRequestReportDAO.insertApprovalHistoryModify(deployRequestFormDTO.getReqId(), deployRequestFormDTO.getUserId());
	}

	
// -----------------------------------------
	public int getTotalStep(List<ApprovalHistoryDTO> approvals) {
		int result = 0;
		String reject = "";
		//System.out.println("---"+approvals.get(0).getReqId()+"---");  // java.lang.IndexOutOfBoundsException 떠서 잠시 주석처림함 
		Collections.reverse(approvals);
		for(ApprovalHistoryDTO approval : approvals) {
			switch(approval.getStatus().getId().intValue()) {
			
			case 2:
					System.out.println("승인");
					reject = "";
					result += 1;
					break;
				case 3:
					System.out.println("반려");
					reject="b";
					result -= 1;
					break;
			}
		}
		
		return result;
	}

	
	
	// approval_history userid(user Empno 추가) - 승인/반려
	public void insertApprovalHistory(Long reportId, long statusId, String content, Long userid) {
		deployRequestReportDAO.insertApprovalHistory2(reportId, statusId, content, userid);
		
	}





}
