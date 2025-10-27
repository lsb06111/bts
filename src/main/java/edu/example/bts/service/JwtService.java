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
	private static final long EXPIRATION_TIME = 1000L * 60 * 30; // 30분

	public String createToken(String email, Long empno, String role) {
		return Jwts.builder().setSubject(email).claim("empno", empno).claim("role", role).setIssuedAt(new Date())
				.setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
				.signWith(SECRET_KEY, SignatureAlgorithm.HS256)
				.compact();
	}

	/** JWT 검증 */
	public boolean validateToken(String token) {
		try {
			// ✅ parserBuilder() + SecretKey 그대로
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
