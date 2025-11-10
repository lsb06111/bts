package edu.example.bts.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.bts.domain.deployRequest.DeployFormDevRepoDTO;
import edu.example.bts.domain.deployRequest.DeployRequestFormDTO.FileDTO;
import edu.example.bts.domain.deployRequest.DeployRequestsDTO;
import edu.example.bts.domain.history.RequestsDTO;

@Mapper
public interface DeployFormDAO {

	List<DeployFormDevRepoDTO> findProjectsByUserId(Long userId);


	
	
	public boolean createRequests(DeployRequestsDTO deployRequestsDTO);
	boolean createApprovalHistory(@Param("reqId") Long id, @Param("statusId") int statusId);
	boolean createCommitFile(@Param("file")FileDTO file,@Param("reqId") Long id);




	DeployFormDevRepoDTO findDevRepoById(Long repoId);
	


}
