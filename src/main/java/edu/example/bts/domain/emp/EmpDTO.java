package edu.example.bts.domain.emp;

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
public class EmpDTO {
	private Long empno;
    private String ename;
    private String ephone;
    private String email;
    private String phone;
    private String estate;
    private int deptno;
    private int jobno;
    private String birthdate;
    private DeptDTO dept;
    private JobDTO job;
    private String company;
}
