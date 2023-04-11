//작성자 : 심현민
//최초 작성일 : 23.04.04
package com.church.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.church.domain.Reply;

public interface ReplyMapper {
	
	@Insert("INSERT INTO reply (bno, rwriter, rcontents) VALUES (#{bno}, #{rwriter}, #{rcontents})")
	void newReply(Map<String, Object> reply);
	
	@Select("SELECT * FROM reply WHERE bno = #{bno}")
	List<Reply> replyList(String bno); 
	
	@Select("SELECT rcontents FROM reply WHERE rno = #{rno}")
	String reply(String rno); 
	
	@Update("UPDATE reply SET rcontents = #{rcontents}, rupdate='수정됨' WHERE rno = #{rno}")
	void editReply(Map<String, Object> reply);

	@Delete("DELETE FROM reply WHERE rno = #{rno}")
	void removeReply(String rno); 

}
