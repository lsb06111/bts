package edu.example.bts.domain.deployRequest;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RequestCommitFileDTO {
	//DB CommitFileDTO 같음
	private Long id;
	private String sha;
	private String fileSha;
	private String fileName;
	private Long reqId;
}
