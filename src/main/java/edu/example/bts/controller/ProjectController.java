package edu.example.bts.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.example.bts.domain.emp.EmpDTO;
import edu.example.bts.domain.project.DevRepoDTO;
import edu.example.bts.domain.user.UserDTO;
import edu.example.bts.service.ProjectService;
import edu.example.bts.service.UserService;

@Controller
@RequestMapping("/project")
public class ProjectController {
	@Autowired
	private ProjectService projectService;

	@Autowired
	private UserService userService;

	@GetMapping("/list")
	public String projectList(@RequestParam(value = "page", defaultValue = "1") Integer page,
			@RequestParam(value = "projectName", required = false) String projectName,
			@RequestParam(value = "currentStage", required = false) String currentStage, Model model) {
		if (page < 1) {
			page = 1;
		}
		int pageSize = 10;
		int offset = (page - 1) * pageSize;
		
		boolean pName = (projectName != null && !projectName.isEmpty());
	    boolean pStage = (currentStage != null && !currentStage.isEmpty());
		
		List<DevRepoDTO> projectList;
		
		int totalCount;
		int totalPage;
		
		// 1) 상태 필터 검색
		if (pStage) {
		    totalCount = projectService.countProjectByStatus(currentStage);
		    projectList = projectService.findPageProjectWithStatus(offset, currentStage);
		}
		// 2) 프로젝트명 검색
		else if (pName) {
		    totalCount = projectService.countProjectByName(projectName);
		    projectList = projectService.findProjectByNamePaging(projectName, offset);
		}
		// 3) 전체 조회
		else {
		    totalCount = projectService.countAllProject();
		    projectList = projectService.findPageProject(offset);
		}
		
		totalPage = (int) Math.ceil((double) totalCount / pageSize);
		if (totalPage == 0) {
			totalPage = 1;
		}

		model.addAttribute("projects", projectList);
		model.addAttribute("page", page);
		model.addAttribute("offset", offset);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("totalPage", totalPage);

		System.out.println("projects" + projectList);
		System.out.println("page" + page);
		System.out.println("offset" + offset);
		System.out.println("totalCount" + totalCount);
		System.out.println("totalPage" + totalPage);
		return "/project/projectList";
	}
	
	// 모달에서 프로젝트 조회하기
	@GetMapping("/employee")
	@ResponseBody
	public Map<String, Object> findAllUser(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "ename", required = false) String ename) {
		int pageSize = 8; // 페이지에 보여줄 데이터
		int totalCount;
		int offset = (page - 1) * pageSize;

		List<EmpDTO> list;
		if (ename != null && !ename.isEmpty()) {
			totalCount = projectService.countUserByEnameInModal(ename);
			list = projectService.findAllUserInModal(offset, ename);
		} else {
			totalCount = userService.countAllUsers();
			list = projectService.findAllUserInModal(offset, null);
		}
		// 현재 페이지 기준 offset
		int totalPage = (int) Math.ceil((double) totalCount / pageSize);

		Map<String, Object> result = new HashMap<>();
		result.put("list", list);
		result.put("page", page);
		result.put("totalCount", totalCount);
		result.put("totalPage", totalPage);

		System.out.println("ename = " + ename + ", totalCount = " + totalCount);

		return result;
	}

	@PostMapping("/add")
	@ResponseBody
	public Map<String, Object> addProject(
	        @ModelAttribute DevRepoDTO project,
	        @RequestParam("memberEmpnos") List<Long> memberEmpnos,
	        @RequestParam("approverEmpno") Long approverEmpno,
	        @RequestAttribute("loginUser") UserDTO loginUser) {

	    Long loginEmpno = loginUser.getEmpno();

	    // 프로젝트 멤버 empno → userId 변환
	    List<Long> memberUserIds = new ArrayList<Long>();
	    for (Long memberEmpno : memberEmpnos) {
	        Long userId = projectService.findUserByEmpno(memberEmpno);
	        if (userId != null) {
	            memberUserIds.add(userId);
	        }
	    }

	    // 결재자 empno → userId 변환
	    Long approverUserId = null;
	    if (approverEmpno != null) {
	        approverUserId = projectService.findUserByEmpno(approverEmpno);
	    }

	    // 프로젝트 생성
	    projectService.createProject(project, memberUserIds, approverUserId, loginEmpno);

	    // 🔥 여기! Java 1.8 이하 호환 JSON 응답
	    Map<String, Object> result = new HashMap<String, Object>();
	    result.put("status", "success");
	    return result;
	}

	@PostMapping("/update")
	public String updateProject(@ModelAttribute DevRepoDTO project,
			@RequestParam(value = "memberIds", required = false) List<Long> memberIds,
			@RequestParam(value = "memberEmpnos", required = false) List<Long> memberEmpnos,
			@RequestParam(value = "approverEmpno", required = false) Long approverEmpno,
			/* @RequestAttribute("loginUser") UserDTO loginUser, */
			RedirectAttributes ra) {

		System.out.println("==== UpdateProject Debug ====");
		System.out.println("projectId = " + project.getId());
		System.out.println("projectName = " + project.getProjectName());
		System.out.println("repoName = " + project.getRepoName());
		System.out.println("ownerUsername = " + project.getOwnerUsername());
		System.out.println("repoToken = " + project.getRepoToken());
		System.out.println("memberEmpnos = " + memberEmpnos);
		System.out.println("approverEmpno = " + approverEmpno);
		System.out.println("currentStage = " + project.getCurrentStage());
		System.out.println("=============================");

		// empno → user_id 변환
		List<Long> memberUserIds = new ArrayList<>();
		if (memberEmpnos != null) {
			for (Long empno : memberEmpnos) {
				Long userId = projectService.findUserByEmpno(empno);
				if (userId != null)
					memberUserIds.add(userId);
			}
		}

		projectService.updateProject(project, memberIds, memberUserIds, approverEmpno);

		ra.addFlashAttribute("msg", "프로젝트 정보가 수정되었습니다.");
		return "redirect:/project/list";

	}
	
	@PostMapping("/delete")
	@ResponseBody
	public Map<String, Object> deleteProject(@RequestParam("id") Long projectId) {

	    projectService.softDeleteProject(projectId);

	    Map<String, Object> result = new HashMap<>();
	    result.put("status", "success");
	    return result;
	}
}
