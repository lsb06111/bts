package edu.example.bts.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.example.bts.dao.MainDAO;
import edu.example.bts.dao.UserDAO;
import edu.example.bts.domain.emp.EmpDTO;
import edu.example.bts.domain.user.UserDTO;

@Service
public class UserService {
	@Autowired
	private UserDAO userDAO;

	// 추가
	@Autowired
	MainDAO mainDAO;

	public EmpDTO findEmpByEmail(String email) {
		return userDAO.findEmpByEmail(email);
	}

	public UserDTO findUserByEmpno(Long empno) {
		return userDAO.findUserByEmpno(empno);
	}

	public void insertUser(UserDTO user) {
		userDAO.insertUser(user);
	}

	// 신규 유저 등록
	public void addUser(UserDTO user) {
		userDAO.insertUser(user);
	}

	// 추가
	public UserDTO getUserByEmail(String email) {
		return mainDAO.getUserByEmail(email);
	}

	// 전체 유저 목록 조회
	public List<UserDTO> findAllUsers() {
		return userDAO.findAllUsers();
	}
	
	public List<UserDTO> findUsersByDept(int deptno) {
	    return userDAO.findUsersByDept(deptno);
	}
	
	public List<UserDTO> findPageUsers(int offset){
		return userDAO.findPageUsers(offset);
	}
	
	public int countAllUsers(){
		return userDAO.countAllUsers();
	}
	
	public List<UserDTO> findUserByEname(String ename){
		return userDAO.findUserByEname(ename);
	}

}
