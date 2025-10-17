package edu.example.bts.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.example.bts.domain.emp.EmpDTO;
import edu.example.bts.domain.user.UserDTO;
import edu.example.bts.service.EmpService;
import edu.example.bts.service.UserService;

@Controller
@RequestMapping("/emp")
public class EmpController {

	@Autowired
	private EmpService empService;

	@Autowired
	private UserService userService;
	
	//
	// 사원 전체 목록 페이지
	@GetMapping
	@RequestMapping("/list")
	public String employeeList(Model model) {
		List<UserDTO> users = userService.findAllUsers();
		model.addAttribute("empList", users);
		return "/employee/employeeList";
	}

	// AJAX: 사원번호로 사원 정보 조회
	@GetMapping("/find")
	@ResponseBody
	public EmpDTO findEmpByEmpno(@RequestParam int empno) {
		EmpDTO emp = empService.findEmpByEmpno(empno);
		System.out.println("[AJAX] empno=" + empno + " → " + emp);
		return emp;
	}

	// ✅ AJAX: 드롭다운 선택에 따라 데이터 조회
	@GetMapping("/filter")
	@ResponseBody
	public Object filterEmployees(@RequestParam(required = false, defaultValue = "ALL") String type) {
		System.out.println("=== [DEBUG] 요청된 type: " + type + " ===");

		if ("BTS".equalsIgnoreCase(type)) {
			System.out.println("[DEBUG] BTS 사용자 목록 조회 실행");
			List<UserDTO> userList = userService.findAllUsers();
			System.out.println("[DEBUG] 조회된 사용자 수: " + userList.size());
			return userList;

		} else if ("ALL".equalsIgnoreCase(type)) {
			System.out.println("[DEBUG] 전체 사원 목록 조회 실행");
			List<EmpDTO> empList = empService.findAllEmps();
			System.out.println("[DEBUG] 조회된 사원 수: " + empList.size());
			return empList;

		} else {
			System.out.println("[WARN] 인식되지 않은 type 값: " + type);
			return Collections.emptyList();
		}
	}

	@GetMapping("/filterDept")
	@ResponseBody
	public Object filterByDept(@RequestParam(required = false, defaultValue = "ALL") String type,
			@RequestParam(required = false, defaultValue = "0") int deptno) {

		System.out.println("=== [DEBUG] 요청된 type=" + type + ", deptno=" + deptno + " ===");

		if ("BTS".equalsIgnoreCase(type)) {
			if (deptno == 0) {
				return userService.findAllUsers();
			} else {
				return userService.findUsersByDept(deptno);
			}
		} else { // ALL
			if (deptno == 0) {
				return empService.findAllEmps();
			} else {
				return empService.findEmpsByDept(deptno);
			}
		}
	}

	@PostMapping("/update")
	@ResponseBody
	public String updateEmployee(@RequestBody EmpDTO emp) {
		System.out.println("[UPDATE 요청] " + emp);
		try {
			empService.updateEmployee(emp);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
}
