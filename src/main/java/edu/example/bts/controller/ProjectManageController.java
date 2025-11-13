package edu.example.bts.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ProjectManageController {
	@RequestMapping("/project")
	public String project() {
		return "/project/projectList";
	}
}
