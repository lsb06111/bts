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
	public String projectList(@RequestParam(value = "page", defaultValue = "1") Integer page, 
			@RequestParam(value = "projectName", required = false) String projectName, Model model) {
		if (page < 1) {
			page = 1;
		}
		int pageSize = 10;
		int offset = (page - 1) * pageSize;
		List<DevRepoDTO> projectList = projectService.findPageProject(offset);;
		int totalCount;
		int totalPage;
		
		if(projectName!=null && !projectName.isEmpty()) {						// 프로젝트명으로 검색
			projectList = projectService.findProjectByProjectName(projectName);
			totalCount = projectList.size();
		} else {
			projectList = projectService.findPageProject(offset);				// 프로젝트 조회
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

}
