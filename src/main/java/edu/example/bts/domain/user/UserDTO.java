package edu.example.bts.domain.user;

import com.fasterxml.jackson.annotation.JsonAutoDetect;

import edu.example.bts.domain.main.DeptDTO;
import edu.example.bts.domain.main.JobDTO;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class UserDTO {
	private Long id;
	private String githubUsername;
	private String password;
	private String ename;
	private int ephone;
	private String email;
	private String phone;
	private String estate;
	private DeptDTO dept;
	private JobDTO job;
	private int empno;
}
