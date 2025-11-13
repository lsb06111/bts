package edu.example.bts.domain.deployRequest;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// 가져올때 쓰거 ?
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommitFileDTO {
	private String commitSha;	// DB저장
	
	private String fileSha;   // 파일 SHA : 커밋 SHA와 다름
	private String fileName;  // DB저장
	private int lineAddd;
	private int lineDeleted;
	private String status;
	
	private String patch; // 파일 비교
	
	
	// --------------------
	
}
