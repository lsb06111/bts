/*package edu.example.bts.jwtFilter;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import edu.example.bts.service.JwtService;

@Component
public class JwtAuthFilter extends OncePerRequestFilter{
	@Autowired
    private JwtService jwtService;

	@Override
    protected void doFilterInternal(HttpServletRequest req,
                                    HttpServletResponse res,
                                    FilterChain chain)
            throws IOException, ServletException {

        String accessToken = getTokenFromCookie(req, "accessToken");
        String refreshToken = getTokenFromCookie(req, "refreshToken");

        // 1 Access Token 먼저 검증
        if (accessToken != null && jwtService.validateToken(accessToken)) {
            authenticate(accessToken);
        }

        // 2 Access Token 만료 + Refresh Token 존재 → 자동 재발급
        else if (refreshToken != null && jwtService.validateToken(refreshToken)) {

            String email = jwtService.getEmailFromToken(refreshToken);
            Long empno = jwtService.getEmpnoFromToken(refreshToken);
            String role = jwtService.getRoleFromToken(refreshToken);

            // 새로운 Access Token 생성
            String newAccessToken =
                    jwtService.createAccessToken(email, empno, role);

            // 새 토큰을 쿠키에 넣기
            Cookie newCookie = new Cookie("accessToken", newAccessToken);
            newCookie.setHttpOnly(true);
            newCookie.setPath("/");
            newCookie.setMaxAge(60 * 30); // 30분
            res.addCookie(newCookie);

            System.out.println("[JWT] Access Token 자동 재발급 완료!");

            // SecurityContext에 사용자 정보 설정
            authenticate(newAccessToken);
        }

        // 3) 둘 다 없거나 invalid → SecurityContext 초기화
        else {
            SecurityContextHolder.clearContext();
        }

        chain.doFilter(req, res);
    }

    // 토큰 기반으로 SecurityContext에 인증 객체 저장
    private void authenticate(String token) {
        String email = jwtService.getEmailFromToken(token);
        String role = jwtService.getRoleFromToken(token);

        UsernamePasswordAuthenticationToken auth =
                new UsernamePasswordAuthenticationToken(
                        email,
                        null,
                        Arrays.asList(new SimpleGrantedAuthority("ROLE_" + role))
                );

        SecurityContextHolder.getContext().setAuthentication(auth);
    }

    // 쿠키에서 특정 이름의 토큰 꺼내기
    private String getTokenFromCookie(HttpServletRequest req, String name) {
        if (req.getCookies() == null) return null;
        for (Cookie cookie : req.getCookies()) {
            if (name.equals(cookie.getName())) {
                return cookie.getValue();
            }
        }
        return null;
    }
}
*/