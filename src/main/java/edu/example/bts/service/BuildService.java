package edu.example.bts.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.apache.ibatis.annotations.Param;
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
	
	//add 이 부분을 바꿔야함 
	public boolean addDeployResults(List<Long> reqIds) {
		for(Long reqId : reqIds) {
			if(!jenkinsDAO.updateResult(reqId, "await", null))
				return false;
		}
		
		return true;
	}
	
	public boolean addDeployResult(Long reqId) {
		return jenkinsDAO.addResult(reqId, "ready");
	}
	
	public boolean updateDeployResult(Long reqId, String resultType, LocalDateTime now) {
		return jenkinsDAO.updateResult(reqId, resultType, now);
	}
	
	public int getRequestsSizeForBuild(UserDTO user, String buildStatus, String keyword, String filter, boolean isCombined) {
		return historyDAO.getRequestsSizeForBuild(user.getId(), buildStatus, keyword, filter, isCombined);
	
	}
	
	public List<RequestsDTO> getRequestsForBuild(UserDTO user, int page, String buildStatus, String keyword, String filter, boolean isCombined){
		return historyDAO.getRequestsForBuildByPage(user.getId(), page, buildStatus, keyword, filter, isCombined);
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
