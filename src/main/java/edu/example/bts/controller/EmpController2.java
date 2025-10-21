package edu.example.bts.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/emp2")
public class EmpController2 {
	@GetMapping("/list2")
	public String employee2() {
		return "employee/employeeList2";
	}

}
