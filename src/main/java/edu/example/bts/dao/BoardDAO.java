package edu.example.bts.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import edu.example.bts.domain.board.NoticeDTO;

@Mapper
public interface BoardDAO {

	public List<NoticeDTO> getNoticeList(Integer page);
}
