package edu.example.bts.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import edu.example.bts.domain.project.DevRepoDTO;

@Mapper
public interface ProjectDAO {
	// 프로젝트 페이지네이션 리스트
	public List<DevRepoDTO> findPageProject(Integer offset);
	
	// 프로젝트 페이지네이션 카운팅
	public int countAllProject();
}
