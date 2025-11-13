package edu.example.bts.domain.deployRequest;

import edu.example.bts.domain.history.StatusDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ApprovalHistoryDetailDTO {
	// approval_history
	private Long id;
	private String createdAt;
	private Long reqId;
	private Long statusId;
	private String content;
	private Long approvalUserId;
	
	// status
	private String description;
	
	// requests
	private Long userID;  // 
	private Long devRepoId;  // 
	
	// approval_line
	private Long empno;   // 
	
	// emp
	private String ename;
	private Long jobno;  //
	private Long deptno;  // 
	
	// job
	private String jname;
	
	// dept
	private String dname;
}
