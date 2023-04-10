//작성자 : 심현민
//최초 작성일 : 23.04.04
package com.church.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneOffset;
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
	public String requestBoardById(@RequestParam("bno") int bno,
									@RequestParam("username") String username,
						            HttpServletRequest request,
						            HttpServletResponse response,
						            Model model) {
		// 게시물
		Board boardById = boardService.boardById(bno);
		model.addAttribute("board", boardById);
		
		// 답변
		List<Reply> list = replyService.replyList(bno);
		int cnt = list.size();
		model.addAttribute("replyList",list);
		model.addAttribute("cnt", cnt);
		
		viewCountValidation(boardById, bno, username, request, response);
		 
		return "boards/board";
	}
	
	 private void viewCountValidation(Board board, 
			 						 int bno,
			 						 String username,
									 HttpServletRequest request, 
									 HttpServletResponse response) {
        Cookie[] cookies = request.getCookies();

        Cookie cookie = null;
        boolean isCookie = false;
        
        // request에 쿠키들이 있을 때
        for (int i = 0; cookies != null && i < cookies.length; i++) {
        	// 사용자명_board 쿠키가 있을 때
            if (cookies[i].getName().equals(username + "_board")) {//다른 게시판은 "_board" 변경 
            	// cookie 변수에 저장
                cookie = cookies[i];
                // 만약 cookie 값에 현재 게시글 번호가 없을 때
                if (!cookie.getValue().contains("[" + board.getBno() + "]")) {
                	// 해당 게시글 조회수를 증가시키고, 쿠키 값에 해당 게시글 번호를 추가
                	boardService.updateView(bno);
                    cookie.setValue(cookie.getValue() + "[" + board.getBno() + "]");
                }
                isCookie = true;
                break;
            }
        }
        
        // 만약 사용자명_board라는 쿠키가 없으면 처음 접속한 것이므로 새로 생성
        if (!isCookie) { 
        	boardService.updateView(bno);
            cookie = new Cookie(username + "_board", "[" + board.getBno() + "]"); // oldCookie에 새 쿠키 생성
        }
        
        // 쿠키 유지시간을 오늘 하루 자정까지로 설정
        long todayEndSecond = LocalDate.now().atTime(LocalTime.MAX).toEpochSecond(ZoneOffset.UTC);
        long currentSecond = LocalDateTime.now().toEpochSecond(ZoneOffset.UTC);
        cookie.setPath("/"); // 모든 경로에서 접근 가능
        cookie.setMaxAge((int) (todayEndSecond - currentSecond + 32400));//크롬 UTC 기준 +9시간(32400초) 필요 
        response.addCookie(cookie);
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
	public String requestEditboard(@RequestParam("bno") int bno, Model model, @ModelAttribute("EditBoard") Board board) {
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
