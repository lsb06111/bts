package edu.example.bts.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.example.bts.dao.HistoryDAO;
import edu.example.bts.dao.MainDAO;
import edu.example.bts.domain.board.NoticeDTO;
import edu.example.bts.domain.history.RequestsDTO;
import edu.example.bts.domain.user.UserDTO;

@Service
public class MainService {

	@Autowired
	MainDAO mainDAO;
	
	@Autowired
	HistoryDAO historyDAO;
	
	public UserDTO getUserDetail(Long id) {
		return mainDAO.getUserDetail(id);
	}
	
	public List<RequestsDTO> getLatestRequestsForS(Long userId){
		return historyDAO.getLatestRequestsForS(userId);
	}
	
	public List<RequestsDTO> getLatestRequestsForT(Long userId){
		return historyDAO.getLatestRequestsForT(userId);
	}
	
	public List<RequestsDTO> getLatestRequestsForU(Long userId){
		return historyDAO.getLatestRequestsForU(userId);
	}
	
	public List<NoticeDTO> getLatestNotice(){
		return historyDAO.getLatestNotice();
	}
}
