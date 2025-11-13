package edu.example.bts.domain.history;

import edu.example.bts.domain.project.DevRepoDTO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RequestsDTO {
	private Long id;
	private String title;
	private String content;
	private String createdAt;
	private boolean isDraft;
	private boolean delYn;
	private Long userId;
	private String ename;
	private DevRepoDTO devRepo;
	private String result;
	private String buildAt;
}
