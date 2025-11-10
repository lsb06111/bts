package edu.example.bts.controller;

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
			@RequestParam(value = "projectName", required = false) String projectName, Model model) {
		if (page < 1) {
			page = 1;
		}
		int pageSize = 10;
		int offset = (page - 1) * pageSize;
		List<DevRepoDTO> projectList = projectService.findPageProject(offset);
		;
		int totalCount;
		int totalPage;

		if (projectName != null && !projectName.isEmpty()) { // 프로젝트명으로 검색
			projectList = projectService.findProjectByProjectName(projectName);
			totalCount = projectList.size();
		} else {
			projectList = projectService.findPageProject(offset); // 프로젝트 조회
			totalCount = projectService.countAllProject();
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

	/*
	 * // AJAX 모달에서 사원 불러오기
	 * 
	 * @GetMapping("/employee")
	 * 
	 * @ResponseBody public List<EmpDTO> findAllUser(@RequestParam(value = "page",
	 * defaultValue = "1") int page) { int pageSize = 6; int offset = (page-1) *
	 * pageSize; return projectService.findAllUserInModal(offset); }
	 */

	@GetMapping("/employee")
	@ResponseBody
	public Map<String, Object> findAllUser(@RequestParam(value = "page", defaultValue = "1") int page) {
		int pageSize = 8; // 페이지에 보여줄 데이터
		int totalCount = userService.countAllUsers(); // 전체 데이터 수
		int totalPage = (int) Math.ceil((double) totalCount / pageSize);

		// 현재 페이지 기준 offset
		int offset = (page - 1) * pageSize;

		List<EmpDTO> list = projectService.findAllUserInModal(offset);

		Map<String, Object> result = new HashMap<>();
		result.put("list", list);
		result.put("page", page);
		result.put("totalCount", totalCount);
		result.put("totalPage", totalPage);

		return result;
	}

	@PostMapping("/add")
	public String addProject(@ModelAttribute DevRepoDTO project,
	                         @RequestParam("memberEmpnos") List<Long> memberEmpnos,
	                         @RequestParam("approverEmpno") Long approverEmpno,
	                         @RequestAttribute("loginUser") UserDTO loginUser,
	                         RedirectAttributes ra) {

	    // JWT에서 로그인 사용자 정보 사용
	    Long empno = loginUser.getEmpno();

	    // 예: 팀장 권한 확인
	    if (loginUser.getEmp() != null 
	        && loginUser.getEmp().getJob().getJobno() == 3 
	        && loginUser.getEmp().getDept().getDeptno() == 1) {

	        projectService.createProject(project, memberEmpnos, approverEmpno, empno);
	        ra.addFlashAttribute("msg", "프로젝트가 등록되었습니다.");
	    } else {
	        ra.addFlashAttribute("msg", "프로젝트 등록 권한이 없습니다.");
	    }

	    return "redirect:/project/list";
	}
}
