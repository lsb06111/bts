package edu.example.bts.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.example.bts.dao.ProjectDAO;
import edu.example.bts.domain.project.DevRepoDTO;

@Service
public class ProjectService {
	@Autowired
	private ProjectDAO projectDAO;
	
	// 프로젝트 페이지네이션 리스트
	public List<DevRepoDTO> findPageProject(int offset){
		return projectDAO.findPageProject(offset);
	}
	
	// 프로젝트 페이지네이션 카운트
	public int countAllProject() {
		return projectDAO.countAllProject();
	}
	
	// 프로젝트명으로 검색하기
	public List<DevRepoDTO> findProjectByProjectName(String projectName){
		return projectDAO.findProjectByProjectName(projectName);
	}
}
