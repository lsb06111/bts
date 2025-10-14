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
public class JwtInterceptor implements HandlerInterceptor{
	@Autowired
    private JwtService jwtService;
	
	//추가
	@Autowired
	private UserService userService;

    @Override
    public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
        
    	String token = null;
    	
    	// check token from header -- added
    	String header = req.getHeader("Authorization");
        if (header != null && header.startsWith("Bearer ")) {
            token = header.substring(7);
            /*if (jwtService.validateToken(token)) {
                return true;
            }*/
        }
        
        // if not exist, check token from cookies -- added
        System.out.println("[DEBUG] Authorization 헤더 = " + req.getHeader("Authorization"));
        if(token == null && req.getCookies() != null) {
        	for (Cookie c : req.getCookies()) {
        		System.out.println("[DEBUG] 쿠키: " + c.getName() + " = " + c.getValue());
                if ("jwt".equals(c.getName())) {
                    token = c.getValue();
                    break;
                }
            }
        }
        
        // if token is valid
        if (token != null && jwtService.validateToken(token)) {
            String email = jwtService.getEmailFromToken(token);

            UserDTO userDTO = userService.getUserByEmail(email);
            System.out.println(userDTO);
            req.setAttribute("loginUser", userDTO);
            return true;
        }
        
        

        res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        res.getWriter().write("토큰이 유효하지 않습니다.");
        return false;
    }
}
