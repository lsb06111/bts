package edu.example.bts.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.example.bts.dao.ProjectDAO;
import edu.example.bts.domain.emp.EmpDTO;
import edu.example.bts.domain.project.DevRepoDTO;
import edu.example.bts.domain.project.ProjectMemberDTO;

@Service
public class ProjectService {
	@Autowired
	private ProjectDAO projectDAO;

	// 프로젝트 페이지네이션 리스트
	public List<DevRepoDTO> findPageProject(int offset) {
		return projectDAO.findPageProject(offset);
	}

	// 프로젝트 페이지네이션 카운트
	public int countAllProject() {
		return projectDAO.countAllProject();
	}

	// 프로젝트명으로 검색하기
	public List<DevRepoDTO> findProjectByProjectName(String projectName) {
		return projectDAO.findProjectByProjectName(projectName);
	}

	// 모달에서 사원 페이지네이션으로 조회하기
	public List<EmpDTO> findAllUserInModal(int offset) {
		return projectDAO.findAllUserInModal(offset);
	}

	@Transactional
	public void createProject(DevRepoDTO project, List<Long> memberEmpnos, Long approverEmpno, Long loginEmpno) {
		// 프로젝트 기본정보 저장
		projectDAO.insertProject(project);
		Long projectId = project.getId();

		// 프로젝트 멤버 저장
		if (memberEmpnos != null) {
			for (Long empno : memberEmpnos) {
				projectDAO.insertProjectMember(projectId, empno);
			}
		}

		// 결재자 등록
		projectDAO.updateProjectApprover(projectId, approverEmpno);

		// 결재라인 등록
		// 로그인한 사람(팀장) → 1단계
		projectDAO.insertApprovalLine(1, loginEmpno, projectId);

		// 운영팀 결재자 → 2단계
		if (approverEmpno != null) {
			projectDAO.insertApprovalLine(2, approverEmpno, projectId);
		}
	}
}
