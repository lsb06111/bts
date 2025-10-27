package edu.example.bts.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import edu.example.bts.domain.user.UserDTO;
import edu.example.bts.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
    private UserService userService;

	@PostMapping("/add")
    public String addUser(@RequestBody UserDTO user) {
        userService.addUser(user);
        return "success";
    }
	
	/* 로그인된 사용자 프로필 페이지 SecurityContext*/
    /*@GetMapping("/profile")
    public String profilePage(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null || !authentication.isAuthenticated()) {
            // 로그인 정보가 없으면 로그인 페이지로 리다이렉트
            return "redirect:/auth/loginForm";
        }

        String email = authentication.getName(); // 로그인된 사용자 이메일
        model.addAttribute("email", email);

        System.out.println("[DEBUG] 로그인 사용자 이메일: " + email);

        return "user/profile";
    }*/
}
