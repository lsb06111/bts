package edu.example.bts.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.example.bts.dao.EmpDAO;
import edu.example.bts.domain.emp.EmpDTO;

@Service
public class EmpService {
	@Autowired
	private EmpDAO empDAO;

	public EmpDTO findEmpByEmpno(int empno) {
		return empDAO.findEmpByEmpno(empno);
	}

	// 전체 사원 목록 조회
	public List<EmpDTO> findAllEmps() {
		System.out.println("=== [DEBUG] 전체 사원 목록 조회 실행 ===");
		return empDAO.findAllEmps();
	}
	
	public List<EmpDTO> findEmpsByDept(int deptno) {
	    return empDAO.findEmpsByDept(deptno);
	}
	
	public void updateEmployee(EmpDTO emp) {
	    empDAO.updateEmp(emp);
	}
}
