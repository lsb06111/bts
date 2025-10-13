package edu.example.bts.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.example.bts.dao.UserDAO;
import edu.example.bts.domain.emp.EmpDTO;
import edu.example.bts.domain.user.UserDTO;

@Service
public class UserService {
	@Autowired
    private UserDAO userDAO;

    public EmpDTO findEmpByEmail(String email) {
        return userDAO.findEmpByEmail(email);
    }

    public UserDTO findUserByEmpno(int empno) {
        return userDAO.findUserByEmpno(empno);
    }

    public void insertUser(UserDTO user) {
        userDAO.insertUser(user);
    }
}
