package edu.example.bts.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.bts.domain.board.NoticeDTO;
import edu.example.bts.domain.board.QnaDTO;
import edu.example.bts.domain.history.ApprovalHistoryDTO;
import edu.example.bts.domain.history.RequestsDTO;
import edu.example.bts.domain.history.StatusDTO;
import edu.example.bts.domain.project.DevRepoDTO;

@Mapper
public interface HistoryDAO {

	public List<RequestsDTO> getRequestsForS(Long userId);
	
	public ApprovalHistoryDTO getLatestApproval(Long reqId);
	
	public List<StatusDTO> getAllStatus();
	
	public List<DevRepoDTO> getAllProjectsForS(Long userId);
	
	public List<QnaDTO> getLatestQnaList();
	
	public List<RequestsDTO> getLatestRequestsForS(Long userId);
	
	public List<RequestsDTO> getLatestRequestsForT(Long userId);
	
	public List<RequestsDTO> getLatestRequestsForU(Long userId);
	
	public List<RequestsDTO> getAllRequestsForS(@Param("userId") Long userId,
												@Param("projectName") String projectName,
												@Param("keyword") String keyword);
	
	public List<RequestsDTO> getAllRequestsForSU(@Param("userId") Long userId,
												 @Param("projectName") String projectName,
												 @Param("keyword") String keyword);
	
	public List<NoticeDTO> getLatestNotice();
	
	public List<QnaDTO> getAllQnaList();
	
	public Integer getRequestsCount(@Param("userId") Long userId,
									@Param("keyword") String keyword);
	
	public Integer getRequestsCountByProjects(@Param("userId") Long userId,
											  @Param("keyword") String keyword);
	
	public List<RequestsDTO> getRequestsByPageForSU(@Param("userId") Long userId, @Param("page") int page);
	
	public List<RequestsDTO> getAllRequestsForSUByProject(@Param("userId") Long userId,
														  @Param("projectName") String projectName);
	
	
	public List<RequestsDTO> getRequestsByPageForS(@Param("userId") Long userId, @Param("page") int page);
	
	//
	public List<RequestsDTO> getRequestsForT(Long userId);
	public List<ApprovalHistoryDTO> getApprovalHistoryForT(Long reqId);
}
