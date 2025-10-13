package edu.example.bts.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.example.bts.domain.emp.EmpDTO;
import edu.example.bts.domain.user.UserDTO;
import edu.example.bts.service.JwtService;
import edu.example.bts.service.UserService;

@Controller
@RequestMapping("/auth")
public class AuthController {

	@Autowired
	private UserService userService;

	@Autowired
	private JwtService jwtService;

	/** 로그인 폼 페이지 이동 */
	@GetMapping("/loginForm")
	public String loginForm() {
		return "auth/login"; // /WEB-INF/views/auth/login.jsp
	}

	/** 로그인 처리 (JWT) */
	@PostMapping("/login")
	public String login(@RequestParam String email, @RequestParam String password, HttpServletResponse response) {
		EmpDTO emp = userService.findEmpByEmail(email);

		if (emp == null)
			return "등록되지 않은 이메일입니다.";

		String role = (emp.getDeptno() == 3) ? "ADMIN" : "USER";

		// 일반 사원은 users 테이블 등록되어 있어야 로그인 가능
		if (role.equals("USER")) {
			UserDTO user = userService.findUserByEmpno(emp.getEmpno());
			if (user == null)
				return "접근 권한이 없습니다.";
			if (!user.getPassword().equals(password))
				return "비밀번호가 일치하지 않습니다.";
		}

		// JWT 토큰 생성 및 헤더에 추가
		String token = jwtService.createToken(email, emp.getEmpno(), role);
		response.setHeader("Authorization", "Bearer " + token);

		System.out.println("[JWT] 발급된 토큰: " + token);
		return "redirect:/";
	}
}
