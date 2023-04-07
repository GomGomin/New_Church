//작성자 : 심현민
//최초 작성일 : 23.04.04
package com.church.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.church.domain.Board;
import com.church.domain.Paging;
import com.church.domain.Reply;
import com.church.service.BoardService;
import com.church.service.ReplyService;

@Controller
@RequestMapping("boards")
public class BoardController {

	@Autowired
	BoardService boardService;
	
	@Autowired
	ReplyService replyService;
	
	@GetMapping("setNewBoard")
	public String requestAddBoardForm(@ModelAttribute("NewBoard") Board board) {
		return "boards/addBoard";
	}
	
	@PostMapping("/setNewBoard") 
	public String submitAddBoardForm(@ModelAttribute("NewBoard") Board board) {
		boardService.newBoard(board);
		
		return "redirect:/boards/list";
	}
	
	@GetMapping("/list")
	public void list(Model model, @RequestParam(value = "num",required = false, defaultValue = "1") int num, 
			@RequestParam(value = "searchType",required = false, defaultValue = "title") String searchType,
			@RequestParam(value = "keyword",required = false, defaultValue = "") String keyword) throws Exception {
		Paging page = new Paging();
		
		page.setNum(num);
		page.setCount(boardService.searchCount(searchType, keyword));
		page.setSearchType(searchType);
		page.setKeyword(keyword);

		List<Board> list = null; 
	    list = boardService.list(page.getDisplayPost(), page.getPostNum(), searchType, keyword);
	 
		model.addAttribute("list", list);
		model.addAttribute("page", page);
		model.addAttribute("select", num);
	 
	}	
	
	@GetMapping("/detail")
	public String requestBoardById(@RequestParam("bno") String bno, @RequestParam("username") String username, Model model, HttpServletRequest req, HttpServletResponse res) {
		// 게시물
		Board boardById = boardService.boardById(bno);
		model.addAttribute("board", boardById);
		
		//작성자 아닐 시에 조회수 증가
		if(!username.equals(boardById.getBwriter())) { viewCountUp(bno, req, res); }
		
		// 답변
		List<Reply> list = replyService.replyList(bno);
		int cnt = list.size();
		model.addAttribute("replyList",list);
		model.addAttribute("cnt", cnt);
		
		return "boards/board";
	}
	
	private void viewCountUp(String bno, HttpServletRequest request, HttpServletResponse response) {

	    Cookie oldCookie = null;
	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals("postView")) {
	                oldCookie = cookie;
	            }
	        }
	    }

	    if (oldCookie != null) {
	        if (!oldCookie.getValue().contains("[" + bno.toString() + "]")) {
	        	boardService.updateView(bno);
	            oldCookie.setValue(oldCookie.getValue() + "_[" + bno + "]");
	            oldCookie.setPath("/");
	            oldCookie.setMaxAge(60 * 60 * 24);
	            response.addCookie(oldCookie);
	        }
	    } else {
	    	boardService.updateView(bno);
	        Cookie newCookie = new Cookie("postView","[" + bno + "]");
	        newCookie.setPath("/");
	        newCookie.setMaxAge(60 * 60 * 24);
	        response.addCookie(newCookie);
	    }
	}
	
	@ResponseBody
	@RequestMapping("/replynew")
	public void replynew(@RequestParam Map<String, Object> reply) {
		boardService.updateReplyCnt(reply.get("bno"));
		replyService.newReply(reply);
	}
	
	@ResponseBody
	@RequestMapping("/removeboard")
	public void removeboard(@RequestParam("bno") String bno) {
		boardService.removeBoard(bno);
	}
	
	@ResponseBody
	@RequestMapping(value="/modal", produces="text/html;charset=utf-8")
	public String modal(@RequestParam("rno") String rno) {
		return replyService.reply(rno);
	}
	
	@ResponseBody
	@RequestMapping(value="/editReply", produces="text/html;charset=utf-8")
	public void editReply(@RequestParam("rno") String rno, @RequestParam("rcontents") String rcontents, Map<String, Object> reply) {
		reply.put("rno", rno);
		reply.put("rcontents", rcontents);
		replyService.editReply(reply);
	}
	
	@ResponseBody
	@RequestMapping("/removereply")
	public void removeReply(@RequestParam("rno") String rno) {
		replyService.removeReply(rno);
	}
	
	@GetMapping("/edit")
	public String requestEditboard(@RequestParam("bno") String bno, Model model, @ModelAttribute("EditBoard") Board board) {
		Board boardById = boardService.boardById(bno);
		model.addAttribute("board", boardById);

		return "boards/editBoard";
	}
	
	@PostMapping("/edit")
	public String submitEditboard(@ModelAttribute("EditBoard") Board board) {
		boardService.editBoard(board);
		return "redirect:/boards/detail?bno="+board.getBno()+"&username="+board.getBwriter();
	}
}
