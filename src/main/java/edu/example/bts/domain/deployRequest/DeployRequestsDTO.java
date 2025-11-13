package edu.example.bts.domain.deployRequest;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DeployRequestsDTO {
    // DB: requests 
	private Long id;               // 요청 ID
    private String title;          // 제목
    private String content;        // 내용
    private String createdAt;   // 생성일시  localDateTime->String
    private Integer isDraft;       // 임시저장 여부 (1:임시, 0:완료)
    private Integer delYn;         // 삭제 여부 (1:삭제, 0:정상)
    private Long userId;           // 작성자 ID
    private Long devRepoId;        // 연관된 dev_repo ID
	
    // 사용자 이름이 필요한데.. 에러날려나?
    private String ename;
    
    public DeployRequestsDTO(String title, String content, Long userId, Long devRepoId) {
		this.title = title;
		this.content = content;
		this.userId = userId;
		this.devRepoId = devRepoId;
	}
	
    
    
}
