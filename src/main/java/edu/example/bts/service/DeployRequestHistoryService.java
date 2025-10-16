package edu.example.bts.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.example.bts.dao.BoardDAO;
import edu.example.bts.dao.HistoryDAO;
import edu.example.bts.dao.MainDAO;
import edu.example.bts.domain.board.QnaDTO;
import edu.example.bts.domain.history.ApprovalHistoryDTO;
import edu.example.bts.domain.history.DevRepoDTO;
import edu.example.bts.domain.history.RequestsDTO;
import edu.example.bts.domain.history.StatusDTO;
import edu.example.bts.domain.user.UserDTO;

@Service
public class DeployRequestHistoryService {

	@Autowired
	HistoryDAO historyDAO;
	
	@Autowired
	MainDAO mainDAO;
	
	@Autowired
	BoardDAO boardDAO;
	
	public List<RequestsDTO> getAllRequestsForS(Long userId){
		return historyDAO.getRequestsForS(userId);
	}
	
	public List<ApprovalHistoryDTO> getLatestApproval(List<RequestsDTO> requests) {
		List<ApprovalHistoryDTO> result = new ArrayList<>();
		for(RequestsDTO req : requests) {
			result.add(historyDAO.getLatestApproval(req.getId()));
		}
		return result;
	}
	
	public List<UserDTO> getUsersByReq(List<RequestsDTO> requests){
		List<UserDTO> result = new ArrayList<>();
		for(RequestsDTO req : requests) {
			result.add(mainDAO.getUserDetail(req.getUserId()));
		} 
		return result;
	}
	
	public List<StatusDTO> getAllStatus(){
		return historyDAO.getAllStatus();
	}
	
	public List<DevRepoDTO> getAllProjectForS(Long userId){
		return historyDAO.getAllProjectsForS(userId);
	}
	
	public Integer getRequestsCount(Long userId) {
		return historyDAO.getRequestsCount(userId);
	}
	
	public List<RequestsDTO> getRequestsByPageForS(Long userId, int page){
		return historyDAO.getRequestsByPageForS(userId, page);
	}
	public Integer getRequestsCountByProjects(Long userId) {
		return historyDAO.getRequestsCountByProjects(userId);
	}
	
	public List<RequestsDTO> getRequestsByPageForSU(Long userId, int page){
		return historyDAO.getRequestsByPageForSU(userId, page);
	}
	
	//
	public List<String> getStatus(List<RequestsDTO> requests, UserDTO user) {
		List<String> result = new ArrayList<>();
		for(RequestsDTO req : requests) {
			List<ApprovalHistoryDTO> approvals = historyDAO.getApprovalHistoryForT(req.getId());
			String totalStep = getTotalStep(approvals);
			int totalStepInt = Integer.parseInt(totalStep.charAt(0)+"");
			String re = "대기중";
			//사원이면
			if(user.getDept().getDeptno().intValue() == 1 && user.getJob().getJobno().intValue() == 2) {
				//System.out.println(req.getId()+": "+totalStep);
				
				if(totalStep.length()==2 && totalStepInt == 0)
					re = "반려";
					
			}//팀장이면
			else if(user.getDept().getDeptno().intValue() == 1 && user.getJob().getJobno().intValue() == 3) {
				
				if(totalStep.length()==2 && totalStepInt == 1)
					re = "반려";
				else if(totalStepInt == 1)
					re = "승인요망";
			}else {
				if(totalStepInt == 2)
					re = "승인요망";
			}
			if(totalStepInt == 3)
				re = "완료";
			result.add(re);
				
		}
		return result;
	}
	public List<RequestsDTO> getRequestsForS(Long userId){
		List<RequestsDTO> results = new ArrayList<>();
		List<RequestsDTO> requests = historyDAO.getRequestsForS(userId);
		for(RequestsDTO req : requests) {
			if(results.size()==3)
				break;
			List<ApprovalHistoryDTO> approvals = historyDAO.getApprovalHistoryForT(req.getId());
			String totalStep = getTotalStep(approvals);
			if(totalStep.length()==2 && Integer.parseInt(totalStep.charAt(0)+"") == 0)
				results.add(req);
		}
		return results;
	}
	
	public List<RequestsDTO> getRequestsForT(Long userId, int targetStep){
		List<RequestsDTO> results = new ArrayList<>();
		List<RequestsDTO> requests = historyDAO.getRequestsForT(userId);
		for(RequestsDTO req : requests) {
			if(results.size()==3)
				break;
			List<ApprovalHistoryDTO> approvals = historyDAO.getApprovalHistoryForT(req.getId());
			int totalStep = Integer.parseInt(getTotalStep(approvals).charAt(0)+"");
			System.out.println("현재 단계(3이면 완료): "+totalStep);
			if(totalStep == targetStep)
				results.add(req);
		}
		return results;
	}
	public String getTotalStep(List<ApprovalHistoryDTO> approvals) {
		int result = 1;
		String reject = "";
		System.out.println("---"+approvals.get(0).getReqId()+"---");
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
		
		return result+reject;
	}
	
	public List<QnaDTO> getLatestQnaList(){
		List<QnaDTO> results = new ArrayList<>();
		List<QnaDTO> qnas = historyDAO.getAllQnaList();
		for(QnaDTO qna : qnas) {
			if(results.size() == 3)
				break;
			if(boardDAO.getReplyByQnaId(qna.getId()) == null)
				results.add(qna);
				
		}
		
		return results;
	}
}
