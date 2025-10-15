package edu.example.bts.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.bts.domain.emp.EmpDTO;

@Mapper
public interface EmpDAO {
	// 사원번호로 사원 조회
	public EmpDTO findEmpByEmpno(@Param("empno") int empno);
	
	// 전 사원 조회
	public List<EmpDTO> findAllEmps();
	
	// 부서별 조회
	public List<EmpDTO> findEmpsByDept(int deptno);
}
