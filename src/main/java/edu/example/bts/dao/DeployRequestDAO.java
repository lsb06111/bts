package edu.example.bts.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DeployRequestDAO {

	String findEmpNameByGitId(String githubUserName);

}
