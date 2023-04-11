//작성자 : 심현민
//최초 작성일 : 23.04.04
package com.church.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.church.domain.Board;

public interface BoardMapper {
	
	@Insert("INSERT INTO board (btitle, bcontents, bwriter) VALUES (#{btitle}, #{bcontents}, #{bwriter})")
	void newBoard(Board board);
	
	@Select("SELECT count(*) FROM board")
	int count();
	
	public List<Board> list(@Param("displayPost") int displayPost, @Param("postNum") int postNum, @Param("searchType") String searchType, @Param("keyword") String keyword);
	
	public int searchCount(@Param("searchType") String searchType, @Param("keyword") String keyword);
	
	@Select("SELECT * FROM board WHERE bno = #{bno}")
	Board boardById(int bno);

	@Update("UPDATE board SET btitle = #{btitle}, bcontents = #{bcontents} WHERE bno = #{bno}")
	void editBoard(Board board);
	
	@Update("UPDATE board SET bview = bview + 1 WHERE bno = #{bno}")
	void updateView(int bno);
	
	@Update("UPDATE board SET replyCount = replyCount + 1 WHERE bno = #{bno}")
	void updateReplyCnt(Object bno);
	
	@Delete("DELETE FROM board WHERE bno = #{bno}")
	void removeBoard(String bno); 
	
}
