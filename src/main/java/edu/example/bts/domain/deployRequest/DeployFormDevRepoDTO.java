package edu.example.bts.domain.deployRequest;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class DeployFormDevRepoDTO {
	// DB: dev_repo
	
	private Long id;
	private String projectName;
    private String ownerUsername;
    private String repoName;
    private String repoToken;
    private String currentStage;
    private Long prodRepoId;
}
