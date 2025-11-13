package edu.example.bts.domain.build;

import edu.example.bts.domain.project.DevRepoDTO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BuildDTO {
	private Long id;
	private String title;
	private String content;
	private String createdAt;
	private boolean isDraft;
	private boolean delYn;
	private Long userId;
	private DevRepoDTO devRepo;
}
