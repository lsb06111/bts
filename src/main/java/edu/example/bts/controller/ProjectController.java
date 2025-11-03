package edu.example.bts.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import edu.example.bts.domain.project.DevRepoDTO;
import edu.example.bts.service.ProjectService;

@Controller
@RequestMapping("/project")
public class ProjectController {
	@Autowired
	private ProjectService projectService;

	@GetMapping("/list")
	public String projectList(@RequestParam(value = "page", defaultValue = "1") Integer page, Model model) {
		if (page < 1) {
			page = 1;
		}
		int pageSize = 10;
		int offset = (page - 1) * pageSize;

		System.out.println("=== ProjectController 실행 ===");
		System.out.println("=== offset: " + offset + " ===");

		List<DevRepoDTO> projectList = projectService.findPageProject(offset);;

		System.out.println("=== Service 결과 === " + projectList); // 여기서 콘솔에 출력되는지 확인

		int totalCount;
		int totalPage;

		projectList = projectService.findPageProject(offset);
		totalCount = projectService.countAllProject();
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

}
