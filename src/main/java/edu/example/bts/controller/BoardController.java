package edu.example.bts.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.example.bts.domain.board.NoticeDTO;
import edu.example.bts.domain.board.QnaDTO;
import edu.example.bts.domain.board.ReplyDTO;
import edu.example.bts.domain.user.UserDTO;
import edu.example.bts.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping("notice")
	public String goNotice(@RequestParam("page") Integer page, Model model) {
		int totalCount = boardService.getNoticeCount();
	    int totalPage = (int) Math.ceil((double) totalCount / 10);
	    
		model.addAttribute("noticeList", boardService.getNoticeList(page-1));
		model.addAttribute("page", page);
	    model.addAttribute("totalPage", totalPage);
		return "board/notice";
	}
	
	@RequestMapping("notice/view")
	public String goNoticeView(@RequestParam("id") long id, Model model) {
		
		model.addAttribute("notice", boardService.getNoticeById(id));
		return "board/view";
	}
	
	@RequestMapping("notice/writeForm")
	public String goNoticeWrite() {
		return "board/noticeWrite";
	}
	
	@ResponseBody
	@PostMapping("notice/write")
	public ResponseEntity<String> postWrite(@RequestAttribute("loginUser") UserDTO user,
											NoticeDTO noticeDTO) {
		noticeDTO.setUserId(user.getId());
		if(boardService.writeNotice(noticeDTO))
			return new ResponseEntity<>("글쓰기 성공", HttpStatus.OK);
		
		return new ResponseEntity<>("글쓰기 실패", HttpStatus.CONFLICT);
	}
	
	@RequestMapping("qna")
	public String goQna(@RequestParam("page") Integer page, Model model) {
		int totalCount = boardService.getQnaCount();
	    int totalPage = (int) Math.ceil((double) totalCount / 10);
	    List<QnaDTO> qnaList = boardService.getQnaList(page-1);
	    
		model.addAttribute("qnaList", qnaList);
		model.addAttribute("page", page);
	    model.addAttribute("totalPage", totalPage);
	    model.addAttribute("replyList", boardService.getReplyList(qnaList));
		return "board/qna";
	}
	
	@RequestMapping("qna/view")
	public String goQnaView(@RequestParam("id") long id, Model model) {
		
		model.addAttribute("qna", boardService.getQnaById(id));
		model.addAttribute("replyList", boardService.getReplyByQnaId(id));
		return "board/qnaView";
	}
	
	@RequestMapping("qna/writeForm")
	public String goQnaWrite() {
		return "board/qnaWrite";
	}
	
	@ResponseBody
	@PostMapping("qna/write")
	public ResponseEntity<String> postQnaWrite(@RequestAttribute("loginUser") UserDTO user,
											QnaDTO qnaDTO) {
		qnaDTO.setUserId(user.getId());
		if(boardService.writeQna(qnaDTO))
			return new ResponseEntity<>("글쓰기 성공", HttpStatus.OK);
		
		return new ResponseEntity<>("글쓰기 실패", HttpStatus.CONFLICT);
	}
	
	@ResponseBody
	@PostMapping("qna/reply")
	public ResponseEntity<String> postQnaReply(ReplyDTO replyDTO){
		if(boardService.writeReply(replyDTO))
			return new ResponseEntity<>("글쓰기 성공", HttpStatus.OK);
		
		return new ResponseEntity<>("글쓰기 실패", HttpStatus.CONFLICT);
	}
	
	@ResponseBody
	@GetMapping("notice/delete")
	public ResponseEntity<String> deleteNotice(Long id){
		if(boardService.deleteNotice(id))
			return new ResponseEntity<>("공지사항 삭제 성공", HttpStatus.OK);
		return new ResponseEntity<>("공지사항 삭제 실패", HttpStatus.CONFLICT);
	}
	
	@ResponseBody
	@GetMapping("qna/delete")
	public ResponseEntity<String> deleteQna(Long id){
		if(boardService.deleteQna(id))
			return new ResponseEntity<>("QnA 삭제 성공", HttpStatus.OK);
		return new ResponseEntity<>("QnA 삭제 실패", HttpStatus.CONFLICT);
	}
	
	@ResponseBody
	@GetMapping("qna/deleteReply")
	public ResponseEntity<String> deleteQnaReply(Long id){
		if(boardService.deleteQnaReply(id))
			return new ResponseEntity<>("답변 삭제 성공", HttpStatus.OK);
		return new ResponseEntity<>("답변 삭제 실패", HttpStatus.CONFLICT);
	}
}
