package edu.example.bts.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.example.bts.dao.DeployFormDAO;
import edu.example.bts.dao.DeployRequestReportDAO;
import edu.example.bts.domain.deployRequest.ApprovalHistoryDetailDTO;
import edu.example.bts.domain.deployRequest.DeployFormDevRepoDTO;
import edu.example.bts.domain.deployRequest.DeployRequestFormDTO;
import edu.example.bts.domain.deployRequest.DeployRequestsDTO;
import edu.example.bts.domain.deployRequest.RequestCommitFileDTO;
import edu.example.bts.domain.deployRequest.DeployRequestFormDTO.FileDTO;
import edu.example.bts.domain.history.ApprovalHistoryDTO;

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
		deployRequestReportDAO.insertApprovalHistoryModify(deployRequestFormDTO.getReqId());
	}







}
