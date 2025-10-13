package edu.example.bts.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.example.bts.domain.emp.EmpDTO;
import edu.example.bts.domain.user.UserDTO;

@Repository
public class UserDAO {
	@Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "edu.example.bts.dao.UserDAO.";

    public EmpDTO findEmpByEmail(String email) {
        return sqlSession.selectOne(NAMESPACE + "findEmpByEmail", email);
    }

    public UserDTO findUserByEmpno(int empno) {
        return sqlSession.selectOne(NAMESPACE + "findUserByEmpno", empno);
    }

    public void insertUser(UserDTO user) {
        sqlSession.insert(NAMESPACE + "insertUser", user);
    }
}
