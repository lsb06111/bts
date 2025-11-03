package edu.example.bts.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.bts.domain.deployRequest.DeployRequestsDTO;
import edu.example.bts.domain.deployRequest.RequestCommitFileDTO;

@Mapper
public interface DeployRequestReportDAO {

	DeployRequestsDTO selectRequestByReportId(@Param("id") Long requestId);

	List<RequestCommitFileDTO> selectCommitFilesByReportId(@Param("req_id")Long requestId);

}
