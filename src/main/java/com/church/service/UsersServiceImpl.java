/*
    작성자 : 강세빈
    작성일 : 2023-04-04
*/

package com.church.service;

import java.util.List;


import com.church.domain.Notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.church.domain.Users;
import com.church.mapper.UsersMapper;

@Service
public class UsersServiceImpl implements UsersService {


	@Autowired
	UsersMapper usersMapper;

	@Override
	public List<Users> listUser(int displayPost, int postNum){
		return usersMapper.listUser(displayPost, postNum);

	}

	@Override
	public void joinUser(Users user) {
		usersMapper.joinUser(user);
	}

	@Override
	public Users detailUser(String username) {
		return usersMapper.detailUser(username);
	}

	@Override

	public void deleteUser(String username) {
		usersMapper.deleteUser(username);

	}

	@Override
	public String findIdUser(String name, String tel) {
		return usersMapper.findIdUser(name, tel);
	}

	@Override

	public String findPw(String name, String tel, String username) {
		return usersMapper.findPw(name, tel, username);
	}

	@Override
	public void updateUsers(String name, String email, String tel, String username) {
		usersMapper.updateUsers(name, email, tel, username);

	}

	@Override
	public void updatePasswordUsers(String password, String username) {
		usersMapper.updatePasswordUsers(password, username);
	}

	@Override
	public int totalCount() {
		return usersMapper.totalCount();
	}

	@Override
	public Users telChk(String tel) {
		return usersMapper.telChk(tel);
	}

	@Override
	public int countUsers() {
		return usersMapper.countUsers();
	}

}
