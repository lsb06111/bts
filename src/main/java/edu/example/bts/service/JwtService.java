package edu.example.bts.service;

import java.util.Date;

import javax.crypto.SecretKey;

import org.springframework.stereotype.Service;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;

@Service
public class JwtService {
	private static final SecretKey SECRET_KEY = Keys.secretKeyFor(SignatureAlgorithm.HS256);
//	private static final long ACCESS_EXPIRATION = 1000L * 10; // 10초
//	private static final long REFRESH_EXPIRATION = 1000L * 15; // 15초
	private static final long ACCESS_EXPIRATION = 1000L * 60 * 30; // 30분
	private static final long REFRESH_EXPIRATION = 1000L * 60 * 60 * 24 * 7; // 7일
	
	/** Access Token 생성 */
	public String createAccessToken(String email, Long empno, String role) {
		return Jwts.builder()
				.setSubject(email)
				.claim("empno", empno)
				.claim("role", role)
				.setIssuedAt(new Date())
				.setExpiration(new Date(System.currentTimeMillis() + ACCESS_EXPIRATION))
				.signWith(SECRET_KEY, SignatureAlgorithm.HS256)
				.compact();
	}

	/** Refresh Token 생성 */
	public String createRefreshToken(String email) {
		return Jwts.builder()
				.setSubject(email)
				.setIssuedAt(new Date())
				.setExpiration(new Date(System.currentTimeMillis() + REFRESH_EXPIRATION))
				.signWith(SECRET_KEY, SignatureAlgorithm.HS256)
				.compact();
	}

	/** JWT 토큰 검증 */
	public boolean validateToken(String token) {
		try {
			// parserBuilder() + SecretKey 그대로
			Jwts.parserBuilder().setSigningKey(SECRET_KEY).build().parseClaimsJws(token);
			return true;
		} catch (JwtException e) {
			return false;
		}
	}

	/** 이메일 추출 */
	public String getEmailFromToken(String token) {
		Claims claims = Jwts.parserBuilder().setSigningKey(SECRET_KEY).build().parseClaimsJws(token).getBody();
		return claims.getSubject();
	}
}
