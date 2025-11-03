package edu.example.bts.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import edu.example.bts.domain.jenkins.DeployResultDTO;
import edu.example.bts.domain.jenkins.JCommitDTO;

@Mapper
public interface JenkinsDAO {

	public List<JCommitDTO> getCommitList();
	
	public List<JCommitDTO> getCommitListByReqId(Long reqId);
	
	public List<Long> getAwaitedReqIds();
	
	public boolean addDeployResult(DeployResultDTO drDTO);
	
	public boolean updateResult(Long reqId);
}
