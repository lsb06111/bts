package edu.example.bts.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.example.bts.dao.DeployFormDAO;
import edu.example.bts.domain.deployRequest.DeployFormDevRepoDTO;
import edu.example.bts.domain.deployRequest.DeployRequestFormDTO;
import edu.example.bts.domain.deployRequest.DeployRequestFormDTO.FileDTO;
import edu.example.bts.domain.deployRequest.DeployRequestsDTO;

@Service
public class DeployFormService {

	@Autowired
	DeployFormDAO deployFormDAO;
	
	
	// 사용자가 속한 진행중인 프로젝트명 찾기
	public List<DeployFormDevRepoDTO> findProjectsByUserId(Long userId) {
		List<DeployFormDevRepoDTO> devRepoByUserIdList = deployFormDAO.findProjectsByUserId(userId);
		
		for(DeployFormDevRepoDTO dto : devRepoByUserIdList) {
			System.out.println(dto.toString());
		}
		
		
		return devRepoByUserIdList;
	}
	
/*
	@Transactional
	public boolean createRequests(DeployRequestsDTO deployRequestsDTO) {
		int statusId = 1;
		boolean createRequests = deployFormDAO.createRequests(deployRequestsDTO);
		boolean createApprovalHistory = deployFormDAO.createApprovalHistory(deployRequestsDTO.getId(), statusId);
		
		if(!createRequests || !createApprovalHistory) {
			// 하나라도 실패하면 둘다  Rollback을 해야할까???
			// throw new RuntimeException("실패!");
			return false;
		}		
		
		return true;
	}
*/
	@Transactional
	public void createRequests(DeployRequestFormDTO deployRequestFormDTO) {
		int statusId = 1;
		DeployRequestsDTO deployRequestsDTO = new DeployRequestsDTO(deployRequestFormDTO.getTitle(), deployRequestFormDTO.getContent(), deployRequestFormDTO.getUserId(), deployRequestFormDTO.getDevRepoId());
		
		
		boolean createRequests = deployFormDAO.createRequests(deployRequestsDTO);
		boolean createApprovalHistory = deployFormDAO.createApprovalHistory(deployRequestsDTO.getId(), statusId);
		for(FileDTO file : deployRequestFormDTO.getSelectedFiles()) {
			deployFormDAO.createCommitFile(file, deployRequestsDTO.getId());			
		}
		
		
		//boolean createCommitFile = deployFormDAO.createCommitFile(); 
	}

}
