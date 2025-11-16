package edu.example.bts.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import edu.example.bts.domain.user.UserDTO;
import edu.example.bts.service.JwtService;
import edu.example.bts.service.UserService;

@Component
public class JwtInterceptor implements HandlerInterceptor {
	@Autowired
	private JwtService jwtService;

	@Autowired
	private UserService userService;

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
		// 쿠키에서 Access Token, Refresh Token 꺼내오기
		String accessToken = getTokenFromCookies(req, "accessToken");
		String refreshToken = getTokenFromCookies(req, "refreshToken");

		// Access Token 유효한 경우 그대로 통과(null or 토큰 유효한지 검증)
		if (accessToken != null && jwtService.validateToken(accessToken)) {
			String email = jwtService.getEmailFromToken(accessToken);
			UserDTO user = userService.getUserByEmail(email);
			req.setAttribute("loginUser", user);
			System.out.println("loginUser email 찾기 :" + user);
			return true; // (컨트롤러로 이동)
		}

		// Access Token 만료 → Refresh Token 검증 시도(null or 토큰 유효한지 검증)
		if (refreshToken != null && jwtService.validateToken(refreshToken)) {
			String email = jwtService.getEmailFromToken(refreshToken); // Refresh Token도 유효하면 email 꺼내기
			UserDTO user = userService.getUserByEmail(email);

			if (user != null) {
				// 새 Access Token 재발급
				String newAccessToken = jwtService.createAccessToken(email, user.getEmpno(), "USER");
				Cookie newAccessCookie = new Cookie("accessToken", newAccessToken);
				newAccessCookie.setHttpOnly(true);
				newAccessCookie.setPath("/");
				newAccessCookie.setMaxAge(60 * 30);
				res.addCookie(newAccessCookie);

				req.setAttribute("loginUser", user);
				System.out.println("[JWT] Access Token 자동 재발급 완료");
				return true;
			}
		}

		// 둘 다 만료 시 로그인 페이지로
		System.out.println("[JWT] 모든 토큰 만료 → 로그인 페이지 이동");
		res.sendRedirect(req.getContextPath() + "/auth/loginForm");
		return false;
	}

	// SecurityContext에 저장
	
	  /*UserDetails userDetails = User.withUsername(email) .password("") // password는
	  필요 없음 .authorities(Collections.emptyList()) .build();
	  
	  UsernamePasswordAuthenticationToken authentication = new
	  UsernamePasswordAuthenticationToken(userDetails, null,
	  userDetails.getAuthorities());
	  SecurityContextHolder.getContext().setAuthentication(authentication);
	  
	  System.out.println("Security 컨텍스트에 저장 체크: " + email);*/
	 

	/** 쿠키에서 토큰 가져오기 */
	private String getTokenFromCookies(HttpServletRequest req, String name) {
		if (req.getCookies() == null)
			return null;
		for (Cookie c : req.getCookies()) {
			if (name.equals(c.getName()))
				return c.getValue();
		}
		return null;
	}
}
