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
	@Options(useGeneratedKeys = true, keyProperty = "username")
	void joinUser(Users user);

	@Select("select * from users where username = #{username}")
	Users detailUser(String username);

	@Delete("Delete from users where username = #{username}")
	void deleteUser(String username);

	@Select("Select username from users where name = #{name} and tel = #{tel}")
	String findIdUser(@Param("name")String name, @Param("tel")String tel);

	@Select("Select * from users where name = #{name} and tel = #{tel} and username = #{username}")
	String findPw(@Param("name")String name, @Param("tel")String tel, @Param("username")String username);

	@Update("Update users Set name = #{name}, email = #{email}, tel = #{tel} where username = #{username}")
	void updateUsers(@Param("name") String name, @Param("email") String email,  @Param("tel") String tel, @Param("username") String username);

	@Update("Update users Set password = #{password} where username = #{username}")
	void updatePasswordUsers(@Param("password") String password, @Param("username") String username);

}
