package edu.example.bts.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.bts.domain.emp.EmpDTO;
import edu.example.bts.domain.user.UserDTO;

@Mapper
public interface UserDAO {
	
	// 전 유저 조회
	public List<UserDTO> findAllUsers();
	
	// 부서별 유저 조회
    public List<UserDTO> findUsersByDept(int deptno);
    
	// 이메일로 사원 조회
	public EmpDTO findEmpByEmail(@Param("email") String email);

	// empno로 유저 조회
	public UserDTO findUserByEmpno(@Param("empno") int empno);

	// 신규 유저 등록
	public void insertUser(UserDTO user);

}
	