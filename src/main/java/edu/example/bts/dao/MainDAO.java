package edu.example.bts.dao;

import org.apache.ibatis.annotations.Mapper;

import edu.example.bts.domain.user.UserDTO;

@Mapper
public interface MainDAO {

	public UserDTO getUserDetail(Long id);
	
	public UserDTO getUserByEmail(String email);
	
	public boolean updateGithubUsername(UserDTO userDTO);
	
	public boolean updatePassword(UserDTO userDTO);
	
	public boolean updatePhone(UserDTO userDTO);

}
