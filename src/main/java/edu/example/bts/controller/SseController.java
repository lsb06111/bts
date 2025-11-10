package edu.example.bts.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import edu.example.bts.service.sse.NotifyService;


@Controller
@RequestMapping("/sse")
public class SseController {

	@Autowired 
	NotifyService notifyService;
	
	@ResponseBody
	@GetMapping(value="/subscribe", produces="text/event-stream;charset=UTF-8")
    public SseEmitter subscribe(@RequestParam Long userId) {
        return notifyService.subscribe(userId);
    }
}
