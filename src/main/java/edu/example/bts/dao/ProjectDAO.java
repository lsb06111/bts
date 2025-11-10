package edu.example.bts.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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

	// insert

	// 프로젝트 기본정보 등록
	public void insertProject(DevRepoDTO project);

	// 프로젝트 멤버 등록
	public void insertProjectMember(@Param("projectId") Long projectId, @Param("empno") Long empno);

	// 프로젝트 결재자 등록 (혹은 수정)
	public void updateProjectApprover(@Param("projectId") Long projectId, @Param("approverEmpno") Long approverEmpno);

	// 결재라인 등록
	public void insertApprovalLine(@Param("order") int order, @Param("empno") Long empno, @Param("projectId") Long projectId);

}