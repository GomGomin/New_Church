/*
    작성자 : 강세빈
    작성일 : 2023-04-04
*/

package com.church.mapper;

import java.util.List;

import org.apache.ibatis.annotations.*;

import com.church.domain.Users;

public interface UsersMapper {

	@Select("select * from users")
	List<Users> listUser();

	@Insert("Insert Into users(username, password, name, email, tel) Values(#{username}, #{password}, #{name}, #{email}, #{tel})")
	@Options(useGeneratedKeys = true, keyProperty = "uno")
	void joinUser(Users user);

	@Select("select * from users where username = #{username}")
	Users detailUser(String username);

	@Delete("Delete from users where username = #{username}")
	void delete(String username);

	@Select("Select username from users where name = #{name} and tel = #{tel}")
	String findIdUser(String name, String tel);

	@Select("Select username from users where name = #{name} and tel = #{tel} and username = #{username}")
	int findPw(String name, String tel, String username);

	@Update("Update users Set name = #{name} and tel = #{tel} and email = #{email} where username = #{username}")
	void updateUsers(String name, String tel, String email, String username);

	@Update("Update users Set password = #{password} where username = #{username}}")
	void updatePasswordUsers(String password, String username);

}
