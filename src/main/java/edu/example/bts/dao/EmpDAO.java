package edu.example.bts.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.bts.domain.emp.EmpDTO;

@Mapper
public interface EmpDAO {
	// 사원번호로 사원 조회
	public EmpDTO findEmpByEmpno(@Param("empno") int empno);
	
	public List<EmpDTO> findAllEmps();
	
	// 사원 정보 수정
	public void updateEmp(EmpDTO emp);
	
	// emp 사원 등록
	public void insertEmp(EmpDTO emp);
	
	// 사원 insert시 empno 세팅
	public Long selectLastEmpno();
}
