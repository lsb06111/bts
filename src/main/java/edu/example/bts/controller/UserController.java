package edu.example.bts.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import edu.example.bts.domain.user.UserDTO;
import edu.example.bts.service.UserService;

@RestController
@RequestMapping("/user")
public class UserController {
	@Autowired
    private UserService userService;

	@PostMapping("/add")
    public String addUser(@RequestBody UserDTO user) {
        userService.addUser(user);
        return "success";
    }
}
