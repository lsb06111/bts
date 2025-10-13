package edu.example.bts.domain.emp;

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
public class EmpDTO {
	private int empno;
    private String ename;
    private String ephone;
    private String email;
    private String phone;
    private String estate;
    private int deptno;
    private int jobno;
}
