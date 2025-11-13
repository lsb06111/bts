package edu.example.bts.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.example.bts.dao.BoardDAO;
import edu.example.bts.domain.board.NoticeDTO;
import edu.example.bts.domain.board.QnaDTO;
import edu.example.bts.domain.board.ReplyDTO;

@Service
public class BoardService {

	@Autowired
	BoardDAO boardDAO;
	
	public List<NoticeDTO> getNoticeList(Integer page){
		return boardDAO.getNoticeList(page);
	}
	
	public Integer getNoticeCount() {
		return boardDAO.getNoticeCount();
	}
	
	public NoticeDTO getNoticeById(Long id) {
		return boardDAO.getNoticeById(id);
	}
	
	public boolean writeNotice(NoticeDTO noticeDTO) {
		return boardDAO.writeNotice(noticeDTO);
	}
	
	public List<QnaDTO> getQnaList(Integer page){
		return boardDAO.getQnaList(page);
	}
	
	public List<ReplyDTO> getReplyList(List<QnaDTO> qnaList){
		List<ReplyDTO> replyList = new ArrayList<>();
		/*for(QnaDTO qna : qnaList) {
			replyList.add(boardDAO.getReplyByQnaId(qna.getId()));
		}*/
		
		return replyList;
	}
	
	public Integer getQnaCount() {
		return boardDAO.getQnaCount();
	}
	
	public QnaDTO getQnaById(Long id) {
		return boardDAO.getQnaById(id);
	}
	public List<ReplyDTO> getReplyByQnaId(Long qnaId) {
		return boardDAO.getReplyByQnaId(qnaId);
	}
	
	public boolean writeQna(QnaDTO qnaDTO) {
		return boardDAO.writeQna(qnaDTO);
	}
	
	public boolean writeReply(ReplyDTO replyDTO) {
		return boardDAO.writeReply(replyDTO);
	}
	
	public boolean deleteNotice(Long id) {
		return boardDAO.deleteNotice(id);
	}
	
	public boolean deleteQna(Long id) {
		return boardDAO.deleteQna(id);
	}
	
	public boolean deleteQnaReply(Long id) {
		return boardDAO.deleteQnaReply(id);
	}
}
