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
	public int countProjectByStatus(String currentStage) {
	    return projectDAO.countProjectByStatus(currentStage);
	}
	
	// 상태 검색
    public List<DevRepoDTO> findPageProjectWithStatus(int offset, String currentStage) {
        return projectDAO.findPageProjectWithStatus(offset, currentStage);
    }
	
	// 프로젝트명 검색 (카운트)
    public int countProjectByName(String Name) {
        return projectDAO.countProjectByName(Name);
    }

    // 프로젝트명 검색 (페이징)
    public List<DevRepoDTO> findProjectByNamePaging(String Name, int offset) {
        return projectDAO.findProjectByNamePaging(Name, offset);
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
	
	@Transactional
	public void softDeleteProject(Long projectId) {
	    projectDAO.deleteProject(projectId);
	}
}
