package edu.example.bts.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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

		// 추가
		Cookie cookie = new Cookie("jwt", token);
		cookie.setHttpOnly(true); // JS 접근 불가 (보안)
		cookie.setPath("/"); // 모든 경로에서 유효
		cookie.setSecure(false);
		cookie.setMaxAge(60 * 60); // 1시간 유효
		response.addCookie(cookie);

		response.setHeader("Authorization", "Bearer " + token);

		System.out.println("[JWT] 발급된 토큰: " + token);
		return "redirect:/";
	}

	/** 로그아웃 처리 */
	@GetMapping("/logout")
	public String logout(HttpServletResponse response) {
		// jwt 쿠키 삭제
		Cookie cookie = new Cookie("jwt", null);
		cookie.setHttpOnly(true);
		cookie.setPath("/");
		cookie.setMaxAge(0); // 즉시 만료
		response.addCookie(cookie);

		System.out.println("[JWT] 로그아웃: 쿠키 삭제 완료");
		return "redirect:/auth/loginForm"; // 로그인 화면으로 이동
	}
}
