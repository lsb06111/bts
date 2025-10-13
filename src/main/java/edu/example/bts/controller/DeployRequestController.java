package edu.example.bts.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DeployRequestController {

	@GetMapping("/deployRequest")
	public String deployRequest() {
		return "/deploy/deployRequest";
	}
}
