package edu.example.bts.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
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
	//////////////////////////////////////

	@GetMapping("/list2")
	public String employee(@RequestParam(value = "page", defaultValue = "1") Integer page,
			@RequestParam(value = "ename", required = false) String ename, Model model) {
		if (page < 1) { // page 1보다 작아도 1고정
			page = 1;
		}
		int pageSize = 10;
		int offset = (page - 1) * pageSize;
		List<UserDTO> users;
		int totalCount;
		int totalPage;

		if (ename != null && !ename.isEmpty()) {
			users = userService.findUserByEname(ename);
			totalCount = users.size();
		} else {
			users = userService.findPageUsers(offset);
			totalCount = userService.countAllUsers(); // 전체 데이터 조회
			
		}
		totalPage = (int) Math.ceil((double) totalCount / pageSize); // 전체 페이지 계산
		if (totalPage == 0) {
			totalPage = 1; // 데이터 없을 때 페이지 1로 고정
		}
		// 디버깅
	    System.out.println("=== [DEBUG] findPageUsers() 결과 확인 ===");
	    for (UserDTO u : users) {
	        System.out.print("User ID: " + u.getId());
	        if (u.getEmp() != null) {
	            System.out.print(" | Empno: " + u.getEmp().getEmpno());
	            System.out.print(" | Ename: " + u.getEmp().getEname());
	            System.out.print(" | Deptno: ");
	            if (u.getEmp().getDept() != null)
	                System.out.print(u.getEmp().getDept().getDeptno());
	            else
	                System.out.print("null");
	        } else {
	            System.out.print(" | Emp: null");
	        }
	        System.out.println();
	    }

		model.addAttribute("users", users);
		model.addAttribute("page", page);
		model.addAttribute("offset", offset);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("ename", ename);

		System.out.println("usersList 값 확인: " + users);
		System.out.println("totalCount: " + totalCount + " totalPage: " + totalPage);
		System.out.println("ename: " + ename);
		return "employee/employeeList2";
	}

	//////////////////////////////////////

	// AJAX: 사원번호로 사원 정보 조회
	@GetMapping("/find")
	@ResponseBody
	public EmpDTO findEmpByEmpno(@RequestParam int empno) {
		EmpDTO emp = empService.findEmpByEmpno(empno);
		System.out.println("[AJAX] empno=" + empno + " → " + emp);
		return emp;
	}

	@PostMapping("/update")
	@ResponseBody
	public String updateEmployee(@ModelAttribute EmpDTO emp) {
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
