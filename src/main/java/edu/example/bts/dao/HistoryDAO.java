package edu.example.bts.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.bts.domain.board.NoticeDTO;
import edu.example.bts.domain.board.QnaDTO;
import edu.example.bts.domain.deployRequest.DeployRequestsDTO;
import edu.example.bts.domain.history.ApprovalHistoryDTO;
import edu.example.bts.domain.history.ApprovalLineDTO;
import edu.example.bts.domain.history.NotificationDTO;
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
	
	public List<RequestsDTO> getAllRequestsForBuild(@Param("userId") Long userId,
													@Param("projectName") String projectName,
													@Param("keyword") String keyword,
													@Param("forCreatedAt") boolean forCreatedAt);
	
	public List<RequestsDTO> getAllRequestsForSUByProject(@Param("userId") Long userId,
														  @Param("projectName") String projectName);
	
	
	public List<RequestsDTO> getRequestsByPageForS(@Param("userId") Long userId, @Param("page") int page);
	
	//
	public List<RequestsDTO> getRequestsForT(Long userId);
	public List<ApprovalHistoryDTO> getApprovalHistoryForT(Long reqId);
	
	public List<ApprovalLineDTO> getApprovalLines(Long devRepoId);
	
	public boolean addNotification(NotificationDTO notificationDTO);
	
	public DeployRequestsDTO getRequestsById(Long reqId);
	
	public List<NotificationDTO> getNotificationsByUserId(Long userId);
	
	public boolean readAllNotifications(Long userId);
	
	public boolean readNotification(Long id);
	
	public boolean updateDeployResult(@Param("reqId") Long reqId,
									@Param("resultType") String result);
	
	public List<RequestsDTO> getRequestsForBuildByPage(@Param("userId") Long userId,
													   @Param("page") int page,
													   @Param("buildStatus") String buildStatus,
													   @Param("keyword") String keyword,
													   @Param("filter") String filter,
													   @Param("isCombined") boolean isCombined);
	
	public int getRequestsSizeForBuild(@Param("userId") Long userId,
								       @Param("buildStatus") String buildStatus,
								       @Param("keyword") String keyword,
								       @Param("filter") String filter,
								       @Param("isCombined") boolean isCombined);
}
