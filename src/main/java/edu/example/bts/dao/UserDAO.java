package edu.example.bts.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.bts.domain.emp.EmpDTO;
import edu.example.bts.domain.user.UserDTO;

@Mapper
public interface UserDAO {
	// 이메일로 사원 조회
	public EmpDTO findEmpByEmail(@Param("email") String email);

	// empno로 유저 조회
	public UserDTO findUserByEmpno(@Param("empno") Long empno);

	// 신규 유저 등록
	public void insertUser(UserDTO user);
	
	// 사원조회 페이지네이션 10개씩 조회
	public List<UserDTO> findPageUsers(Integer page);
	
	// 사원조회 페이지네이션 카운팅
	public int countAllUsers();
	
	// ename으로 사원 조회
	public List<UserDTO> findUserByEname(@Param("ename") String ename);
}
