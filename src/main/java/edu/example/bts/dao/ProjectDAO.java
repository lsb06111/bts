package edu.example.bts.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import edu.example.bts.domain.emp.EmpDTO;
import edu.example.bts.domain.project.DevRepoDTO;

@Mapper
public interface ProjectDAO {
	// 프로젝트 페이지네이션 리스트
	public List<DevRepoDTO> findPageProject(Integer page);
	
	// 프로젝트 페이지네이션 카운팅
	public int countAllProject();
	
	// 프로젝트명으로 검색하기
	public List<DevRepoDTO> findProjectByProjectName(String projectName);
	
	// 모달에서 사원 리스트 페이지네이션으로 불러오기
	public List<EmpDTO> findAllUserInModal(int offset);
	
}