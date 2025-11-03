package edu.example.bts.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.example.bts.dao.HistoryDAO;
import edu.example.bts.dao.JenkinsDAO;
import edu.example.bts.domain.history.ApprovalHistoryDTO;
import edu.example.bts.domain.history.RequestsDTO;
import edu.example.bts.domain.jenkins.DeployResultDTO;
import edu.example.bts.domain.user.UserDTO;

@Service
public class BuildService {

	@Autowired
	HistoryDAO historyDAO;
	
	@Autowired
	JenkinsDAO jenkinsDAO;
	
	public boolean addDeployResult(List<Long> reqIds) {
		for(Long reqId : reqIds) {
			DeployResultDTO drDTO = new DeployResultDTO();
			drDTO.setReqId(reqId);
			drDTO.setResult("await");
			if(!jenkinsDAO.addDeployResult(drDTO))
				return false;
		}
		
		return true;
	}
	
	public int getRequestsSizeForBuild(UserDTO user, int page, String projectName, String keyword) {
		
		List<RequestsDTO> allReq = historyDAO.getAllRequestsForBuild(user.getId(), projectName, keyword);
		int count = 0;
		for(RequestsDTO req : allReq) {
			
			List<ApprovalHistoryDTO> approvals = historyDAO.getApprovalHistoryForT(req.getId());
			int totalStep = getTotalStep(approvals);
			System.out.println(req.getId()+"의 토탈스텝: "+totalStep);
			if(totalStep == 3) { // 승인인 것만
				count++;
			}
		
		}
		return count;
	
	}
	
	public List<RequestsDTO> getRequestsForBuild(UserDTO user, int page, String projectName, String keyword){
		List<RequestsDTO> results = new ArrayList<>();
		List<RequestsDTO> allReq = historyDAO.getAllRequestsForBuild(user.getId(), projectName, keyword);
		int count = 0;
		for(RequestsDTO req : allReq) {
			if(results.size() == 10)
				break;
			
			List<ApprovalHistoryDTO> approvals = historyDAO.getApprovalHistoryForT(req.getId());
			int totalStep = getTotalStep(approvals);
			System.out.println(req.getId()+"의 토탈스텝: "+totalStep);
			if(totalStep == 3) { // 승인인 것만
				if(++count > page*10)
					results.add(req);
			}
		
		}
		
		return results;
	}
	
	public int getTotalStep(List<ApprovalHistoryDTO> approvals) {
		int result = 1;
		
		Collections.reverse(approvals);
		for(ApprovalHistoryDTO approval : approvals) {
			switch(approval.getStatus().getId().intValue()) {
				case 1:
					result = 1;
					break;
				case 2:
					System.out.println("승인");
					result += 1;
					break;
				case 3:
					System.out.println("반려");
					result -= 1;
					break;
			}
		}
		
		return result;
	}
}
