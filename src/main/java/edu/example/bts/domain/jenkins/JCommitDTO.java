package edu.example.bts.domain.jenkins;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class JCommitDTO {
	private String sha;
	private String fileName;
}
