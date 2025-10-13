package edu.example.bts.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.example.bts.dao.HistoryDAO;
import edu.example.bts.dao.MainDAO;
import edu.example.bts.domain.history.ApprovalHistoryDTO;
import edu.example.bts.domain.history.DevRepoDTO;
import edu.example.bts.domain.history.RequestsDTO;
import edu.example.bts.domain.history.StatusDTO;
import edu.example.bts.domain.user.UserDTO;

@Service
public class DeployRequestHistoryService {

	@Autowired
	HistoryDAO dao;
	
	@Autowired
	MainDAO mainDao;
	
	public List<RequestsDTO> getAllRequestsForS(Long userId){
		return dao.getRequestsForS(userId);
	}
	
	public List<ApprovalHistoryDTO> getLatestApproval(List<RequestsDTO> requests) {
		List<ApprovalHistoryDTO> result = new ArrayList<>();
		for(RequestsDTO req : requests) {
			result.add(dao.getLatestApproval(req.getId()));
		}
		return result;
	}
	
	public List<UserDTO> getUsersByReq(List<RequestsDTO> requests){
		List<UserDTO> result = new ArrayList<>();
		for(RequestsDTO req : requests) {
			result.add(mainDao.getUserDetail(req.getUserId()));
		}
		return result;
	}
	
	public List<StatusDTO> getAllStatus(){
		return dao.getAllStatus();
	}
	
	public List<DevRepoDTO> getAllProjectForS(Long userId){
		return dao.getAllProjectsForS(userId);
	}
}
