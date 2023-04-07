/*
    작성자 : 강세빈
    작성일 : 2023-04-04
*/

package com.church.controller;

import com.church.domain.Users;
import com.church.service.MailService;
import com.church.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.security.Principal;

@Controller
public class UsersController {

	@Autowired
	UsersService usersService;

	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;

	@Autowired
	MailService mailService;

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

			//email을 채워서 가입했다면 메일을 전송한다.
			if(user.getEmail() != null && !user.getEmail().equals("")) {
				String to = user.getEmail();
				String subject = "교회에 오신 것을 환영합니다.";

				//TODO: body html 적용해서 예쁘게 만들기
				String body = "교회에 오신 것을 환영합니다. 축하드립니다.";

				mailService.sendMail(to, subject, body);
			}

			return "redirect:/login";
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

	//TODO 관리자 페이지
	@GetMapping("/listUsers") //유저 목록 페이지 출력
	public String ListUsers(Model model) {
		return "users/listUsers";
	}


	@GetMapping("/updateUser") //유저 정보 수정 페이지 (이름, 이메일, 전화번호)
	public String UpdateUser(@ModelAttribute("UpdateUser") Users user, Principal principal, Model model) {
		String username = principal.getName();
		Users userDetail = usersService.detailUser(username);
		model.addAttribute("user", userDetail);

		return "users/updateUser";
	}


	@PostMapping("/updateUser") //유저 정보 수정 페이지 제출 후 처리
	public String SubmitUpdateUser(@ModelAttribute("UpdateUser") Users user, Principal principal, Model model) {
		String username = principal.getName();
		String name = user.getName();
		String email = user.getEmail();
		String tel = user.getTel();

		usersService.updateUsers(name, email, tel, username);

		return "redirect:/main";
	}

	//TODO 비밀번호 변경 페이지
	@GetMapping("/updatePw") //비밀번호 변경 페이지
	public String UpdatePw(Model model) {
		return "users/updatePw";
	}

	@ResponseBody
	@PostMapping("/updatePw") //비밀번호 변경 페이지 제출 후 처리
	public boolean SubmitUpdatePw(@RequestParam String password, @RequestParam String currentPassword, Principal principal,Model model) {
		String username = principal.getName(); //로그인한 유저 ID 받아오기
		Users user = usersService.detailUser(username); //로그인한 유저의 정보 받아오기
		String realPassword = user.getPassword(); //로그인한 유저의 PW 받아오기

		//입력받은 현재 비밀번호와 실제 로그인한 유저의 비밀번호 비교
		boolean matches = bcryptPasswordEncoder.matches(currentPassword, realPassword);

		if (matches) { //두 비밀번호가 같으면
			//form에서 받아온 비밀번호 암호화
			String encodedPassword = bcryptPasswordEncoder.encode(password);

			usersService.updatePasswordUsers(encodedPassword, username);

			return true; //true 반환
		} else { //두 비밀번호가 다르면
			return false; //false 반환
		}

	}

	//TODO 회원 탈퇴
	@PostMapping("/deleteUser")
	public String deleteUser(Principal principal, Model model) {
		String username = principal.getName();

		usersService.deleteUser(username);

		return "redirect:/main";
	}


	@GetMapping("/detailUser") //유저 상세 페이지
	public String DetailUser(Principal principal, Model model) {
		String username = principal.getName();
		Users user = usersService.detailUser(username);
		model.addAttribute("user", user);

		return "users/detailUser";
	}

	@GetMapping("/findId") //아이디 찾기 페이지
	public String FindId(Model model) {
		return "users/findId";
	}

	@ResponseBody
	@PostMapping(value="/findId", produces = "text/html;charset=UTF-8") //아이디 찾기 제출 후 처리
	public String submitFindId(@RequestParam String name, @RequestParam String tel) {
		String username = usersService.findIdUser(name, tel);

		if (username == null || username.equals("") ) {
			return "<p>아이디가 존재하지 않습니다.<br>이름과 전화번호를 확인해주세요.</p>";
		} else {
			return "<p>찾으시는 아이디는<span style=\"color:green\">" + username + "</span>입니다.</p>";
		}
	}

	@GetMapping("/findPw") //비밀번호 찾기 페이지
	public String FindPw(Model model) {
		return "users/findPw";
	}

	@ResponseBody
	@PostMapping("/findPw") //비밀번호 찾기 제출 후 처리
	public String submitFindPw(@RequestParam String name, @RequestParam String tel, @RequestParam String username) {
		return usersService.findPw(name, tel, username);
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
