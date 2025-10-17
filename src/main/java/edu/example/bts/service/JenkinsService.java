package edu.example.bts.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.example.bts.dao.JenkinsDAO;
import edu.example.bts.domain.jenkins.JCommitDTO;

@Service
public class JenkinsService {

	@Autowired
	JenkinsDAO jenkinsDAO;
	
	public List<JCommitDTO> getCommitList(){
		return jenkinsDAO.getCommitList();
	}
}
