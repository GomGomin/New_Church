//작성자 : 김도영
//최초 작성일 : 23.04.04
package com.church.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
		
		String userId = null;
		
		if(principal != null) {
		userId = principal.getName();
		pickBoard.setPbwriter(userId);
		}
		pickUpsService.insert(pickBoard);
		
		

		return "redirect:/pickup/detail?pbwriter=" + userId;
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
	public String detail(@RequestParam("pbwriter") String pbwriter, Model model, HttpServletRequest request) {
        if (pbwriter == null) {
            HttpSession session = request.getSession();
            String errorMessage;

            errorMessage = "존재하지 않는 게시물 입니다.<br>다시 이용해주세요.";

            session.setAttribute("errorMessage", errorMessage);

            return "redirect:/";
        }
		try {
			//주 게시물
			PickBoard pickUpById = pickUpsService.detail(pbwriter);
			model.addAttribute("pickBoard", pickUpById);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/pickUp/detail";
	}


	@GetMapping("/list")
	public String list(Model model) {
		try {
			List<PickBoard> accessList = pickUpsService.accessList();
			List<PickBoard> denyList = pickUpsService.denyList();
			model.addAttribute("accessList", accessList);
			model.addAttribute("denyList", denyList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/pickUp/list";
	}

	@GetMapping("/modify")
	public String modify(@RequestParam("pbwriter") String pbwriter, Principal principal, Model model, HttpServletRequest request) {
        if (pbwriter == null) {
            HttpSession session = request.getSession();
            String errorMessage;

            errorMessage = "존재하지 않는 게시물 입니다.<br>다시 이용해주세요.";

            session.setAttribute("errorMessage", errorMessage);

            return "redirect:/";
        }
		
		
		
		try {
			PickBoard pickUpById = pickUpsService.detail(pbwriter);
			model.addAttribute("pickBoard", pickUpById);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
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
		try {
			pickUpsService.update(pickBoard);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@PostMapping("/formModify")
	public String modify(@RequestParam Map<String, Object> pickBoard) {
		
		try {
			pickUpsService.update(pickBoard);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return "redirect:/pickup/detail?pbwriter=" + pickBoard.get("pbwriter");
	}
	
	@ResponseBody
	@PostMapping("/access")
	public void access(@RequestParam String pbno) {
		try {
			pickUpsService.access(pbno);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	public boolean hasPickupHistory(String username) {
			int hasPickUp = pickUpsService.hasPickupHistory(username);
			if (hasPickUp > 0) {
			    return true;
			} else {
				return false;
			}
		}
	
	
}
