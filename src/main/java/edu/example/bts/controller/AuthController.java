package edu.example.bts.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

	@GetMapping("/loginForm")
	public String loginForm() {
		return "auth/login";
	}

	/** 로그인 처리 (Access + Refresh Token 발급) */
	@PostMapping("/login")
	public String login(@RequestParam String email, @RequestParam String password, HttpServletResponse response,
			RedirectAttributes redirectAttributes) {
		EmpDTO emp = userService.findEmpByEmail(email);
		// 이메일 검증
		if (emp == null) {
			redirectAttributes.addFlashAttribute("errorEmail", "등록되지 않은 이메일 입니다.");
			return "redirect:/auth/loginForm";
		}
		UserDTO user = userService.findUserByEmpno(emp.getEmpno());
		// 사용자 정보 조회
		if (user == null) {
			redirectAttributes.addFlashAttribute("errorNotUser", "접근 권한이 없습니다.");
			return "redirect:/auth/loginForm";
		}
		// 비밀번호 검증
		if (!user.getPassword().equals(password)) {
			redirectAttributes.addFlashAttribute("errorPassword", "비밀번호가 일치하지 않습니다.");
			return "redirect:/auth/loginForm";
		}

		String role = (emp.getDeptno() == 3) ? "ADMIN" : "USER";

		// Access & Refresh Token 생성
		String accessToken = jwtService.createAccessToken(email, emp.getEmpno(), role);
		String refreshToken = jwtService.createRefreshToken(email);
		
		// 쿠키에 저장
		addCookie(response, "accessToken", accessToken, 60 * 30); // 30분
		addCookie(response, "refreshToken", refreshToken, 60 * 60 * 24 * 7); // 7일

		System.out.println("[JWT] Access Token 발급 완료");
		System.out.println("[JWT] Refresh Token 발급 완료");
		return "redirect:/";
	}

	/** 로그아웃 처리 */
	@GetMapping("/logout")
	public String logout(HttpServletResponse response) {
		deleteCookie(response, "accessToken");
		deleteCookie(response, "refreshToken");
		System.out.println("[JWT] 로그아웃: 모든 토큰 삭제 완료");
		return "redirect:/auth/loginForm";
	}

	/** 쿠키 추가 메서드 **/
	private void addCookie(HttpServletResponse response, String name, String value, int maxAge) {
		Cookie cookie = new Cookie(name, value);
		cookie.setHttpOnly(true);
		cookie.setSecure(false);
		cookie.setPath("/");
		cookie.setMaxAge(maxAge);
		response.addCookie(cookie);
	}

	/** 쿠키 삭제 메서드 **/
	private void deleteCookie(HttpServletResponse response, String name) {
		Cookie cookie = new Cookie(name, null);
		cookie.setHttpOnly(true);
		cookie.setPath("/");
		cookie.setMaxAge(0);
		response.addCookie(cookie);
	}
}
