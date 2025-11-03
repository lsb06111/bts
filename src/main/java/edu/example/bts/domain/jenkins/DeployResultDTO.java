package edu.example.bts.domain.jenkins;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DeployResultDTO {

	private Long id;
	private Long reqId;
	private String result;
	private String response;
}
