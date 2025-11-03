package edu.example.bts.domain.deployRequest;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class DeployRequestsDTO {
    
	private Long id;               // 요청 ID
    private String title;          // 제목
    private String content;        // 내용
    private LocalDateTime createdAt;   // 생성일시
    private Integer isDraft;       // 임시저장 여부 (1:임시, 0:완료)
    private Integer delYn;         // 삭제 여부 (1:삭제, 0:정상)
    private Long userId;           // 작성자 ID
    private Long devRepoId;        // 연관된 dev_repo ID
	
    
    
    public DeployRequestsDTO(String title, String content, Long userId, Long devRepoId) {
		this.title = title;
		this.content = content;
		this.userId = userId;
		this.devRepoId = devRepoId;
	}
	
    
    
}
