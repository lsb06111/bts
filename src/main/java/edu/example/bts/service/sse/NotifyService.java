package edu.example.bts.service.sse;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import edu.example.bts.dao.HistoryDAO;
import edu.example.bts.domain.history.ApprovalLineDTO;


@Service
public class NotifyService {

	private final Map<Long, SseEmitter> emitters = new ConcurrentHashMap<>();

	@Autowired
	HistoryDAO historyDAO;
	
    /** 구독 생성 (컨트롤러에서 호출) */
    public SseEmitter subscribe(Long userId) {
        // 타임아웃 30분 (필요에 따라 조절)
        SseEmitter emitter = new SseEmitter(30L * 60L * 1000L);

        // 등록 및 정리 콜백
        emitters.put(userId, emitter);
        emitter.onCompletion(() -> emitters.remove(userId));
        emitter.onTimeout(() -> emitters.remove(userId));
        emitter.onError(e -> emitters.remove(userId));

        // 첫 신호
        try { emitter.send(SseEmitter.event().name("INIT").data("connected")); }
        catch (Exception ignore) {}

        return emitter;
    }

    /** 단일 사용자에게 알림 푸시 */
    public boolean notifyUser(Long userId, Object payload) {
        return userId != -1 ? Optional.ofNullable(emitters.get(userId))
                .map(emitter -> {
                    try {
                        emitter.send(SseEmitter.event()
                                .name("REQUEST_CREATED")
                                .data(payload));
                        return true;
                    } catch (Exception e) {
                        emitters.remove(userId);
                        return false;
                    }
                })
                .orElse(false) : false;
    }
    
    public Long getNextApprovalLine(Long devRepoId, Long userId, Long reqUserId) {
    	List<ApprovalLineDTO> approvalLines = historyDAO.getApprovalLines(devRepoId);
    	Long result = -1L; //approvalLines.get(0).getUserId();
    	boolean found = false;
    	
    	for(ApprovalLineDTO appLine : approvalLines) {
    		if(found) {
    			result = appLine.getUserId();
    			break;
    		}
    		if(appLine.getUserId() == userId)
    			found = true;
    	}
    	if(!found) { // found but 운영
    		result = approvalLines.get(0).getUserId();
    	}
    	
    		
    	return result;
    }
    
    public Long getPreviousApprovalLine(Long devRepoId, Long userId, Long reqUserId) {
    	List<ApprovalLineDTO> approvalLines = historyDAO.getApprovalLines(devRepoId);
    	Long result = reqUserId;
    	boolean found = false;
    	for(int i = approvalLines.size()-1; i >= 0; i--) {
    		ApprovalLineDTO appLine = approvalLines.get(i);
    		if(found) {
    			result = appLine.getUserId();
    			break;
    		}
    		if(appLine.getUserId() == userId)
    			found = true;
    	}
    	
    		
    	return result;
    }
}
