package edu.example.bts.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.example.bts.dao.BoardDAO;
import edu.example.bts.domain.board.NoticeDTO;

@Service
public class BoardService {

	@Autowired
	BoardDAO boardDAO;
	
	public List<NoticeDTO> getNoticeList(Integer page){
		return boardDAO.getNoticeList(page);
	}
}
