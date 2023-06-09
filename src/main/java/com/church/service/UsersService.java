/*
    작성자 : 강세빈
    작성일 : 2023-04-04
*/

package com.church.service;

import java.util.List;

import com.church.domain.Users;

public interface UsersService {

	List<Users> listUser(int displayPost, int postNum);

	void joinUser(Users user);

	Users detailUser(String username);

	void deleteUser(String username);

	String findIdUser(String name, String tel);

	String findPw(String name, String tel, String username);

	void updateUsers(String name, String email, String tel, String username);

	void updatePasswordUsers(String password, String username);

	int totalCount();

	Users telChk(String tel);

	int countUsers();
}
