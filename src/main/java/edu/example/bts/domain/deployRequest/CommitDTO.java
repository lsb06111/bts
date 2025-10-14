package edu.example.bts.domain.deployRequest;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class CommitDTO {
	private String sha;
	private String commitMessage;
	private String authorName;
	private String authorDate;
	
	private String userName;
}
