package edu.example.bts.domain.history;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ApprovalHistoryDTO {
	private Long id;
	private String content;
	private String createdAt;
	private Long reqId;
	private StatusDTO status;
}
