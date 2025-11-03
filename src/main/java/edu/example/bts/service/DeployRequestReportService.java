package edu.example.bts.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.example.bts.dao.DeployRequestReportDAO;
import edu.example.bts.domain.deployRequest.DeployRequestsDTO;
import edu.example.bts.domain.deployRequest.RequestCommitFileDTO;

@Service
public class DeployRequestReportService {

	@Autowired
	DeployRequestReportDAO deployRequestReportDAO;
	
	public DeployRequestsDTO getRequestByReportId(Long requestId) {
		return deployRequestReportDAO.selectRequestByReportId(requestId);

	}

	public List<RequestCommitFileDTO> getCommitFilesByReportId(Long requestId) {
		return deployRequestReportDAO.selectCommitFilesByReportId(requestId);
		//return null;
	}

}
