package edu.example.bts.domain.deployRequest;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DeployRequestFormDTO {
	private Long devRepoId;
	
	private String title;
	private String content;

	private Long userId;
	private Long reqId;
	
	private List<FileDTO> selectedFiles;
	
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	@Builder
	public static class FileDTO{
		private String fileSha; // 파일sha
		private String sha;  	// 커밋sha
		private String fileName;		
	}
	

}
