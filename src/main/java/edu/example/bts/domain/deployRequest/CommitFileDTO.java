package edu.example.bts.domain.deployRequest;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class CommitFileDTO {
	private String sha;   // DB저장
	private String fileName;  // DB저장
	private int lineAdded;
	private int lineDeleted;
	private String status;
	
	private String patch; // 파일 비교
	//이전파일이름 
}
