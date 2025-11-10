package edu.example.bts.sse;

import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Component
public class SseEmitterRepository {
/*
	private final Map<Long, SseEmitter> emitters = new ConcurrentHashMap<>();
	
	public SseEmitter save(Long userId, SseEmitter emitter) {
		emitters.put(userId, emitter);
		emitter.onCompletion(() -> emitters.remove(userId));
        emitter.onTimeout(() -> emitters.remove(userId));
        emitter.onError(e -> emitters.remove(userId));
        return emitter;
	}
	
	public Optional<SseEmitter> get(Long userId) {
        return Optional.ofNullable(emitters.get(userId));
    }
	
    public void remove(Long userId) {
    	emitters.remove(userId);
    }
    */
}
