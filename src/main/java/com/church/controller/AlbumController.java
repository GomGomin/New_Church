package com.church.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.church.domain.Albums;
import com.church.service.AlbumsService;
import com.church.service.ChatGPTService;

@Controller
@RequestMapping("/album")
public class AlbumController {
	
	@Autowired
	private AlbumsService albumsService;
	
	@ResponseBody
	@PostMapping(value="/answer", produces="text/plain;charset=UTF-8")
	public String answer(@RequestParam String prompt, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String answer = ChatGPTService.chatGPT(prompt);
		return answer;
	}
	
	@RequestMapping(value = "/chat", method = RequestMethod.GET)
	public String header() {
		return "/album/header";
	}
	
	@GetMapping("/add")
	public String add(@ModelAttribute("albums") Albums albums) {
		return "/album/add";
	}
	
	@PostMapping("/add")
	public String addAlbums(@ModelAttribute("albums") Albums albums) {
		albumsService.insert(albums);
		return "redirect:/album/list";
	}
	
	@GetMapping("/delete")
	public String delete() {
		return "/album/delete";
	}
	
	@ResponseBody
	@PostMapping("/delete")
	public void deleteAlbums(@RequestParam String ano) {
		albumsService.delete(ano);
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam("ano") String ano, Model model) {
		
		//조회수 증가
		albumsService.updateView(ano);
		
		//주 게시물
		Albums albumsById = albumsService.detail(ano);
		model.addAttribute("albums", albumsById);
		
		return "/album/detail";
	}
	
	@GetMapping("/list")
	public String list(Model model) {
		List<Albums> albumList = albumsService.list();
		model.addAttribute("albumList", albumList);
		return "/album/list";
	}
	
	@GetMapping("/modify")
	public String modify() {
		return "/album/modify";
	}
	
	@ResponseBody
	@PostMapping("/modify")
	public void editAlbum(@RequestParam Map<String, Object> albums) {
		albumsService.update(albums);
	}
	
}
