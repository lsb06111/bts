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
	public List<EmpDTO> findAllUserInModal(@Param("offset") int offset, @Param("ename") String ename);

	// 모달에서 검색시에 결과 카운팅
	public int countUserByEnameInModal(String ename);

	// 프로젝트 생성(dev_repo)
	public void insertProject(DevRepoDTO project);

	// 프로젝트에 멤버 추가
	public void insertProjectMember(@Param("projectId") Long ProjectId, @Param("userId") Long userId);

	// empno로 user.id 조회
	public Long findUserByEmpno(Long empno);

	// 결재라인 생성
	public void insertProjectApprovalLine(@Param("projectId") Long projectId,
			@Param("approverUserId") Long approverUserId, @Param("order") int order);

	// Update 프로젝트
	public void updateProject(DevRepoDTO project);

	// Update 프로젝트 멤버
	public void updateProjectMember(@Param("projectId") Long projectId, @Param("memberId") Long memberId,
			@Param("userId") Long userId);

	// Update 결재라인
	public void updateApproval(@Param("projectId") Long projectId, @Param("approverEmpno") Long approverEmpno);

	// 기존 멤버 삭제
	public void deleteProjectMembers(@Param("projectId") Long projectId);
}