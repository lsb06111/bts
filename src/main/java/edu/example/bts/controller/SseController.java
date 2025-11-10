package edu.example.bts.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import edu.example.bts.sse.SseEmitterRepository;

@Controller
@RequestMapping("/sse")
public class SseController {
	/*
	@Autowired
	SseEmitterRepository repo;

    @GetMapping(value = "/subscribe", produces = "text/event-stream;charset=UTF-8")
    @ResponseBody
    public SseEmitter subscribe(@RequestParam("userId") Long userId) {
        //타임아웃 30분
        SseEmitter emitter = new SseEmitter(30L * 60L * 1000L);
        repo.save(userId, emitter);

        try {
            emitter.send(SseEmitter.event().name("INIT").data("connected"));
        } catch (Exception ignore) {}

        return emitter;
    }
    */
}
