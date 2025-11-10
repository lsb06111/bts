package edu.example.bts.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import edu.example.bts.sse.SseEmitterRepository;

@Service
public class NotifyService {
	/*
	@Autowired 
	SseEmitterRepository repo;

    public boolean notifyUser(Long userId, Object payload) {
        return repo.get(userId).map(emitter -> {
            try {
                emitter.send(SseEmitter.event()
                        .name("REQUEST_CREATED")
                        .data(payload));
                return true;
            } catch (Exception e) {
                repo.remove(userId);
                return false;
            }
        }).orElse(false);
    }
    */
}
