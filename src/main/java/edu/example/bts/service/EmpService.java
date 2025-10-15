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

	// 전체 사원 조회
	public List<EmpDTO> findAllEmps() {
		return empDAO.findAllEmps();
	}
	
	// 부서별 사원 조회
	public List<EmpDTO> findEmpsByDept(int deptno) {
        return empDAO.findEmpsByDept(deptno);
    }
}
