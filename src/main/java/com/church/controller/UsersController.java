/*
    작성자 : 강세빈
    작성일 : 2023-04-04
*/

package com.church.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.church.domain.Users;
import com.church.service.UsersService;

@Controller
public class UsersController {

	@Autowired
	UsersService usersService;

	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;

	@GetMapping("/joinUser") //회원가입 페이지
	public String JoinUser(@ModelAttribute("JoinUser") Users user) {
		return "users/joinUser";
	}

	@PostMapping("/joinUser") //회원가입 페이지 제출 후 처리
	public String SubmitJoinUser(@ModelAttribute("JoinUser") Users user, @RequestParam boolean validate) {
		if (validate) { //유효성 검사를 모두 통과하면
			//form에서 받아온 비밀번호 암호화
			String encodedPassword = bcryptPasswordEncoder.encode(user.getPassword());
			//암호화 한 값은 user 객체에 저장
			user.setPassword(encodedPassword);

			//비밀번호 암호화가 끝난 user 객체를 DB에 저장 (UserService의 joinUser 함수)
			usersService.joinUser(user);

			return "redirect:/main";
		} else { //유효성 검사에서 걸렸으면
			return "redirect:/joinUser";
		}
	}


	@RequestMapping("/login")
	public String Login(HttpServletRequest request, Model model) {
		// 로그인 실패 시 에러 메시지가 request에 담겨있는 경우 모델에 추가
		if (request.getParameter("error") != null) {
			String errorMessage = (String) request.getAttribute("errorMessage");
			model.addAttribute("error", errorMessage);
		}

		return "users/login";
	}


	@GetMapping("/listUsers") //유저 목록 페이지 출력
	public String ListUsers(Model model) {
		return "users/listUsers";
	}

	@GetMapping("/updateUser") //유저 정보 수정 페이지 (이름, 이메일, 전화번호)
	public String UpdateUser(Model model) {
		return "users/updateUser";
	}

	@PostMapping("/updateUser") //유저 정보 수정 페이지 제출 후 처리
	public String SubmitUpdateUser(Model model) {
		return "users/updateUser";
	}

	@GetMapping("/updatePw") //비밀번호 변경 페이지
	public String UpdatePw(Model model) {
		return "users/updatePw";
	}

	@PostMapping("/updatePw") //비밀번호 변경 페이지 제출 후 처리
	public String SubmitUpdatePw(Model model) {
		return "users/updatePw";
	}

	@GetMapping("/detailUser") //유저 상세 페이지
	public String DetailUser(Model model) {
		return "users/detailUser";
	}

	@GetMapping("/findId") //아이디 찾기 페이지
	public String FindId(Model model) {
		return "users/findId";
	}

	@PostMapping("/findId") //아이디 찾기 제출 후 처리
	public String submitFindId(Model model) {
		return "users/findId";
	}

	@GetMapping("/findPw") //아이디 찾기 페이지
	public String FindPw(Model model) {
		return "users/FindPw";
	}

	@PostMapping("/findPw") //아이디 찾기 제출 후 처리
	public String submitFindPw(Model model) {
		return "users/FindPw";
	}

	@ResponseBody
	@RequestMapping("/IdChk") //아이디 중복 확인
	public Boolean IdChk(@RequestParam String username) {
		Users user = usersService.detailUser(username); //username으로 users를 select한다.

		if(user == null) {
			return true; //select한 값이 없으면
		} else {
			return false; //select한 값이 존재하면
		}
	}
}
