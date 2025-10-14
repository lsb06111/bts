package edu.example.bts.domain.board;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class QnaDTO {
	private Long id;
	private String title;
	private String content;
	private String createdAt;
	private String modifiedAt;
	private boolean delYn;
	private Long userId;
	private String ename;
	private ReplyDTO reply;
}
