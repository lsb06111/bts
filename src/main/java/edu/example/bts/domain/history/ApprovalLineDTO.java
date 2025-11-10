package edu.example.bts.domain.history;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ApprovalLineDTO {

	private Long id;
	private int approvalOrder;
	private Long empno;
	private Long userId;
	private Long devRepoId;
}
