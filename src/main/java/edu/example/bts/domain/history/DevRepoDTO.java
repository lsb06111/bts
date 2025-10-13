package edu.example.bts.domain.history;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DevRepoDTO {
	private Long id;
	private String projectName;
	private String ownerUsername;
	private String repoName;
	private String currentStage;
	//private Long prodRepoId;
}
