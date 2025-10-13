package edu.example.bts.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.example.bts.dao.HistoryDAO;
import edu.example.bts.dao.MainDAO;
import edu.example.bts.domain.history.RequestsDTO;
import edu.example.bts.domain.user.UserDTO;

@Service
public class MainService {

	@Autowired
	MainDAO dao;
	
	@Autowired
	HistoryDAO historyDao;
	
	public UserDTO getUserDetail(Long id) {
		return dao.getUserDetail(id);
	}
	
	public List<RequestsDTO> getLatestRequestsForS(Long userId){
		return historyDao.getLatestRequestsForS(userId);
	}
	
	public List<RequestsDTO> getLatestRequestsForT(Long userId){
		return historyDao.getLatestRequestsForT(userId);
	}
	public List<RequestsDTO> getLatestRequestsForU(Long userId){
		return historyDao.getLatestRequestsForU(userId);
	}
}
