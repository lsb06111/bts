package edu.example.bts.domain.user;

import edu.example.bts.domain.emp.EmpDTO;
import edu.example.bts.domain.main.DeptDTO;
import edu.example.bts.domain.main.JobDTO;
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
	private Long empno;
	private String company;
	private EmpDTO emp;
}
