package edu.example.bts.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.example.bts.domain.emp.EmpDTO;
import edu.example.bts.service.EmpService;
import edu.example.bts.service.UserService;

@Controller
@RequestMapping("/emp")
public class EmpController {

	@Autowired
	private EmpService empService;
	
	@Autowired
	private UserService userService;

	// 전 사원 조회
	@GetMapping("/list")
    public String listAll(Model model) {
        model.addAttribute("empList", empService.findAllEmps());
        return "employee/employeeList";
    }

    @GetMapping("/listByDept")
    public String listByDept(@RequestParam(required = false) Integer deptno, Model model) {
    	 if (deptno == null) {
    	        model.addAttribute("empList", empService.findAllEmps());
    	    } else {
    	        model.addAttribute("empList", empService.findEmpsByDept(deptno));
    	    }
    	    return "employee/employeeList";
    }

    @GetMapping("/bts/list")
    public String btsListAll(Model model) {
        model.addAttribute("empList", userService.findAllUsers());
        return "employee/employeeList";
    }

    @GetMapping("/bts/listByDept")
    public String btsListByDept(@RequestParam(required = false) Integer deptno, Model model) {
    	if (deptno == null) {
            model.addAttribute("empList", userService.findAllUsers());
        } else {
            model.addAttribute("empList", userService.findUsersByDept(deptno));
        }
        return "employee/employeeList";
    }

	// AJAX: 사원번호로 사원 정보 조회
	@GetMapping("/find")
	@ResponseBody
	public EmpDTO findEmpByEmpno(@RequestParam int empno) {
		EmpDTO emp = empService.findEmpByEmpno(empno);
		System.out.println("[AJAX] empno=" + empno + " → " + emp);
		return emp;
	}
}
