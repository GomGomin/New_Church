/*
    작성자 : 박지원
    작성일 : 2023-04-10
*/

package com.church.mapper;

import com.church.domain.Event;
import com.church.domain.SearchCondition;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface EventMapper {
    @Select("SELECT * FROM event WHERE eno = #{eno}") // 게시글 한개 조회
    Event selectOne(int eno) throws Exception; ;
    @Insert("INSERT INTO event" +
                " (etitle,econtents,ewriter,efile,eimg)" +
            " VALUES" +
                " (#{etitle},#{econtents},#{ewriter},#{efile},#{eimg})")
    int insertevent(Event event) throws Exception; ; // 게시물 등록
    @Delete("DELETE FROM event WHERE eno = #{eno}")
    int deleteForAdmin(int eno) throws Exception; ; // 글 삭제 (관리자)
    @Update("UPDATE event" +
            " SET etitle = #{etitle}, econtents = #{econtents}, efile = #{efile}, eimg = #{eimg}" +
            " WHERE eno = #{eno}")
    int updateevent(Event event) throws Exception; ; //게시글 수정
    @Update("UPDATE event" +
            " SET eview = eview + 1" +
            " WHERE eno = #{eno}")
    int updateViewCnt(int eno) throws Exception; ; //조회수 카운트 + 1
    int selectSearchCount(SearchCondition sc) throws Exception; ; //키워드 검색 포함 게시물 수
    List<Event> selectSearchPage(SearchCondition sc) throws Exception; ; //키워드 검색 포함 페이지 목록

    @Delete("DELETE FROM event")
    int deleteAll() throws Exception; ; // 글 전체 삭제(테스트코드용)

    @Select("SELECT count(*) FROM event")
    int count();
}
