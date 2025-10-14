package edu.example.bts.domain.board;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReplyDTO {

	private Long id;
	private String content;
	private String createdAt;
	private boolean delYn;
	private Long qnaId;
}
