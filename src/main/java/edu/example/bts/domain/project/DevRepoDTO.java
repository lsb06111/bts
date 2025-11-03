package edu.example.bts.domain.project;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DevRepoDTO {
	/*PROJECT_NAME            VARCHAR2(20)  
	OWNER_USERNAME          VARCHAR2(20)  
	REPO_NAME               VARCHAR2(50)  
	REPO_TOKEN              VARCHAR2(255) 
	CURRENT_STAGE           VARCHAR2(9)   
	PROD_REPO_ID   NOT NULL NUMBER*/
	private Long id;
	private String projectName;
	private String ownerUsername;
	private String repoName;
	private String repoToken;
	private String currentStage;
	private Long prodRepoId;
	private String memberNames; 	// LISTAGG(e.ename, ', ') AS memberNames 매핑용
}
