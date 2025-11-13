package edu.example.bts.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import edu.example.bts.domain.board.NoticeDTO;
import edu.example.bts.domain.board.QnaDTO;
import edu.example.bts.domain.board.ReplyDTO;

@Mapper
public interface BoardDAO {

	public List<NoticeDTO> getNoticeList(Integer page);
	
	public Integer getNoticeCount();
	
	public NoticeDTO getNoticeById(Long id);
	
	public boolean writeNotice(NoticeDTO noticeDTO);
	
	public List<QnaDTO> getQnaList(Integer page);
	
	public Integer getQnaCount();
	
	public QnaDTO getQnaById(Long id);
	
	public List<ReplyDTO> getReplyByQnaId(Long qnaId);
	
	public boolean writeQna(QnaDTO qnaDTO); 
	
	public boolean writeReply(ReplyDTO replyDTO);
	
	public boolean deleteNotice(Long id);
	
	public boolean deleteQna(Long id);
	
	public boolean deleteQnaReply(Long id);
}
