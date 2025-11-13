package edu.example.bts.dao;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.bts.domain.jenkins.DeployResultDTO;
import edu.example.bts.domain.jenkins.JCommitDTO;

@Mapper
public interface JenkinsDAO {

	public List<JCommitDTO> getCommitList();
	
	public List<JCommitDTO> getCommitListByReqId(Long reqId);
	
	public List<Long> getAwaitedReqIds();
	
	public boolean addResult(@Param("reqId") Long reqId, @Param("resultType") String resultType);
	
	public boolean addDeployResult(DeployResultDTO drDTO);
	
	public boolean updateResult(@Param("reqId") Long reqId, 
			@Param("resultType") String resultType,
			@Param("buildAt") LocalDateTime now);
}
