package edu.example.bts.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.example.bts.dao.EmpDAO;
import edu.example.bts.dao.MainDAO;
import edu.example.bts.dao.UserDAO;
import edu.example.bts.domain.emp.EmpDTO;
import edu.example.bts.domain.user.UserDTO;

@Service
public class UserService {
	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	private EmpDAO empDAO;

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
	
	public List<UserDTO> findPageUsers(int offset){
		return userDAO.findPageUsers(offset);
	}
	
	public int countAllUsers(){
		return userDAO.countAllUsers();
	}
	
	public List<UserDTO> findUserByEname(String ename){
		return userDAO.findUserByEname(ename);
	}
	
	@Transactional // 사원등록 Register
	public void registerNewEmployee(UserDTO userDTO, EmpDTO empDTO) {
		// 1) EMP insert (IDENTITY 자동 생성)
	    empDAO.insertEmp(empDTO);

	    // 2) MyBatis가 채워준 사번을 그대로 사용
	    Long empno = empDTO.getEmpno();
	    if (empno == null) {
	        throw new IllegalStateException("생성된 empno가 null입니다.");
	    }

	    // 3) USERS.empno 연결 후 insert
	    userDTO.setEmpno(empno);
	    userDAO.insertUser(userDTO);
	}
}
