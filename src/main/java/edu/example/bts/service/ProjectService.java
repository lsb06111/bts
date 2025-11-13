package edu.example.bts.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.example.bts.dao.ProjectDAO;
import edu.example.bts.domain.emp.EmpDTO;
import edu.example.bts.domain.project.DevRepoDTO;

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
	public List<EmpDTO> findAllUserInModal(int offset, String ename) {
		return projectDAO.findAllUserInModal(offset, ename);
	}
	
	// 모달에서 사원 검색시 결과 카운팅
	public int countUserByEnameInModal(String ename) {
		return projectDAO.countUserByEnameInModal(ename);
	}

	@Transactional
	public void createProject(DevRepoDTO project, List<Long> memberUserIds, Long approverUserId, Long loginEmpno) {
		System.out.println("서비스단 값 넘겨 받음");
		System.out.println(project.getProjectName());
		System.out.println(project.getRepoName());
		System.out.println(project.getOwnerUsername());
		System.out.println(project.getRepoToken());
		System.out.println(memberUserIds);
		System.out.println(approverUserId);
		/*		
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
		*/
		
		//프로젝트 등록
		projectDAO.insertProject(project);
		Long projectId = project.getId(); // useGeneratedKeys로 자동매핑
		System.out.println("서비스단 projectId 체크 : " + projectId);
		
		//멤버 등록
		if(memberUserIds != null && !memberUserIds.isEmpty()) {
			for(Long userId : memberUserIds) {
				projectDAO.insertProjectMember(projectId,userId);
			}
		}
		System.out.println("멤버 등록 완료");
		// 결재자 등록 
		if(approverUserId != null) {
			projectDAO.insertProjectApprovalLine(projectId, loginEmpno, 1);
			
			projectDAO.insertProjectApprovalLine(projectId, approverUserId, 2);
		}
		System.out.println("결재자 등록 완료");
		
	}
	
	public Long findUserByEmpno(Long empno) {
		return projectDAO.findUserByEmpno(empno);
	}
	
	@Transactional
    public void updateProject(DevRepoDTO project, List<Long> memberIds, List<Long> userIds, Long approverEmpno) {

        projectDAO.updateProject(project);
        Long projectId = project.getId();

        // 멤버 업데이트 (각 멤버의 id를 알고 있다는 전제)
        /*for (int i = 0; i < memberIds.size(); i++) {
            projectDAO.updateProjectMember(projectId, memberIds.get(i), userIds.get(i));
        }*/
        
        // 기존 멤버 싹 삭제 후 다시 삽입
        projectDAO.deleteProjectMembers(projectId);
        if (userIds != null && !userIds.isEmpty()) {
            for (Long userId : userIds) {
                projectDAO.insertProjectMember(projectId, userId);
            }
        }

        // 결재자 교체
        if (approverEmpno != null) {
            projectDAO.updateApproval(projectId, approverEmpno);
        }
    }
}
