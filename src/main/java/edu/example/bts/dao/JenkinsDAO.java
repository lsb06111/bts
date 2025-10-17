package edu.example.bts.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import edu.example.bts.domain.jenkins.JCommitDTO;

@Mapper
public interface JenkinsDAO {

	public List<JCommitDTO> getCommitList();
}
