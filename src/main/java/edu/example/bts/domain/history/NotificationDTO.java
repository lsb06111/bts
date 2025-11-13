package edu.example.bts.domain.history;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NotificationDTO {
	private Long id;
	private String title;
	private String slug;
	private boolean isRead;
	private Long userId;
	private Long fromUserId;
	private String createdAt;
	private String ename;
	private String message;
}
