//작성자 : 심현민
//최초 작성일 : 23.04.04
package com.church.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.church.domain.Notice;

public interface NoticeMapper {

    @Insert("INSERT INTO notice (ntitle, ncontents, nwriter) VALUES (#{ntitle}, #{ncontents}, #{nwriter})")
    void newNotice(Notice notice);

    @Select("SELECT count(*) FROM notice")
    int count();

    List<Notice> list(@Param("displayPost") int displayPost, @Param("postNum") int postNum, @Param("searchType") String searchType, @Param("keyword") String keyword);

    int searchCount(@Param("searchType") String searchType, @Param("keyword") String keyword);

    @Select("SELECT * FROM notice WHERE nno = #{nno}")
    Notice noticeById(int nno);

    @Update("UPDATE notice SET ntitle = #{ntitle}, ncontents = #{ncontents} WHERE nno = #{nno}")
    void editNotice(Notice notice);

    @Update("UPDATE notice SET nview = nview + 1 WHERE nno = #{nno}")
    void updateView(int nno);

    @Delete("DELETE FROM notice WHERE nno = #{nno}")
    void removeNotice(String nno);

}