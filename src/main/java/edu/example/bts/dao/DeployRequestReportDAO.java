package edu.example.bts.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.bts.domain.deployRequest.ApprovalHistoryDetailDTO;
import edu.example.bts.domain.deployRequest.DeployFormDevRepoDTO;
import edu.example.bts.domain.deployRequest.DeployRequestsDTO;
import edu.example.bts.domain.deployRequest.RequestCommitFileDTO;
import edu.example.bts.domain.history.ApprovalHistoryDTO;

@Mapper
public interface DeployRequestReportDAO {

	DeployRequestsDTO selectRequestByReportId(@Param("id") Long requestId);

	List<RequestCommitFileDTO> selectCommitFilesByReportId(@Param("req_id")Long requestId);

	DeployFormDevRepoDTO selectDevRepoById(@Param("id")Long devRepoId);

	void insertApprovalHistory(@Param("req_id")Long reportId, @Param("status_id") long statusId, @Param("content") String content);

	List<ApprovalHistoryDetailDTO> findApprovalHistoryDetailList(@Param("req_id")Long requestId);

	List<ApprovalHistoryDTO> findApprovalHistoryByReqId(@Param("req_id")Long requestId);

	List<String> findApprovalLinesByDevRepoId(@Param("reqId")Long reqId);



	
}
