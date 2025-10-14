package edu.example.bts.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import edu.example.bts.interceptor.JwtInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Autowired
    private JwtInterceptor jwtInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(jwtInterceptor)
                .addPathPatterns("/**") // ✅ 모든 요청에 적용
                .excludePathPatterns(     // 로그인, 회원가입 등 인증 제외
                        "/css/**",
                        "/js/**",
                        "/images/**",
                        "/error"
                );
    }
}
