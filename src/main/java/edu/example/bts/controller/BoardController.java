package edu.example.bts.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import edu.example.bts.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping("notice")
	public String goNotice(Model model, @RequestParam("page") Integer page) {
		
		model.addAttribute("noticeList", boardService.getNoticeList(page-1));
		return "board/notice";
	}
	
	@RequestMapping("qna")
	public String goQna() {
		return "board/qna";
	}
	
	
}
