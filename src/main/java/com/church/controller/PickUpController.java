package com.church.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.church.domain.PickBoard;
import com.church.domain.Users;
import com.church.service.PickUpsService;
import com.church.service.UsersService;

@Controller
@RequestMapping("pickup")
public class PickUpController {
	 
	@Autowired
	private UsersService usersService;

	@Autowired
	private PickUpsService pickUpsService;
	
	@GetMapping("/add")
	public String add(@ModelAttribute("pickBoard") PickBoard pickBoard, Principal principal, Model model) {
		
		if(principal != null) {
		String userId = principal.getName();
		Users user = usersService.detailUser(userId);
		model.addAttribute("uname", user.getName());
		}
		
		return "/pickUp/add";
	}
	
	@PostMapping("/add")
	public String addPickUp(@ModelAttribute("pickBoard") PickBoard pickBoard, Principal principal) {
		
		if(principal != null) {
		String userId = principal.getName();
		pickBoard.setPbwriter(userId);
		}
		
		pickUpsService.insert(pickBoard);
		
		

		return "redirect:/pickup/list";
	}
	
	@GetMapping("/delete")
	public String delete() {
		return "/pickUp/delete";
	}
	
	@RequestMapping("/jusoPopup")
	public String jusoPopup() {
		return "/pickUp/jusoPopup";
	}
	
	@ResponseBody
	@PostMapping("/delete")
	public void deleteBoard(@RequestParam String pbno) {
		pickUpsService.delete(pbno);
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam("pbwriter") String pbwriter, Model model) {
		
		//주 게시물
		PickBoard pickUpById = pickUpsService.detail(pbwriter);
		model.addAttribute("pickBoard", pickUpById);
		
		return "/pickUp/detail";
	}


	@GetMapping("/list")
	public String list(Model model) {
		List<PickBoard> accessList = pickUpsService.accessList();
		List<PickBoard> denyList = pickUpsService.denyList();
		model.addAttribute("accessList", accessList);
		model.addAttribute("denyList", denyList);
		return "/pickUp/list";
	}

	@GetMapping("/modify")
	public String modify(@RequestParam("pbwriter") String pbwriter, Principal principal, Model model) {
		
		PickBoard pickUpById = pickUpsService.detail(pbwriter);
		model.addAttribute("pickBoard", pickUpById);
		
		if(principal != null) {
		String userId = principal.getName();
		Users user = usersService.detailUser(userId);
		model.addAttribute("uname", user.getName());
		}
		
		return "/pickUp/modify";
	}
	
	@ResponseBody
	@PostMapping("/modify")
	public void editBoard(@RequestParam Map<String, Object> pickBoard) {
		pickUpsService.update(pickBoard);
	}
	
	@PostMapping("/formModify")
	public String modify(@RequestParam Map<String, Object> pickBoard) {
		pickUpsService.update(pickBoard);
		return "redirect:/pickup/list";
	}
	
	@ResponseBody
	@PostMapping("/access")
	public void access(@RequestParam String pbno) {
		pickUpsService.access(pbno);
	}
}
