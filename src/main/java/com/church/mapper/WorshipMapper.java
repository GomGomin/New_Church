/*
    작성자 : 박지원
    작성일 : 2023-04-10
*/

package com.church.mapper;

import com.church.domain.Worship;
import com.church.domain.SearchCondition;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface WorshipMapper {
    @Select("SELECT * FROM worship WHERE wno = #{wno}") // 게시글 한개 조회
    Worship selectOne(int wno) throws Exception; ;
    @Insert("INSERT INTO worship" +
            " (wtitle,wcontents,wwriter,wfile,wimg)" +
            " VALUES" +
            " (#{wtitle},#{wcontents},#{wwriter},#{wfile},#{wimg})")
    int insertworship(Worship worship) throws Exception; ; // 게시물 등록
    @Delete("DELETE FROM worship WHERE wno = #{wno}")
    int deleteForAdmin(int wno) throws Exception; ; // 글 삭제 (관리자)
    @Update("UPDATE worship" +
            " SET wtitle = #{wtitle}, wcontents = #{wcontents}, wfile = #{wfile}, wimg = #{wimg}" +
            " WHERE wno = #{wno}")
    int updateworship(Worship worship) throws Exception; ; //게시글 수정
    @Update("UPDATE worship" +
            " SET wview = wview + 1" +
            " WHERE wno = #{wno}")
    int updateViewCnt(int wno) throws Exception; ; //조회수 카운트 + 1
    int selectSearchCount(SearchCondition sc) throws Exception; ; //키워드 검색 포함 게시물 수
    List<Worship> selectSearchPage(SearchCondition sc) throws Exception; ; //키워드 검색 포함 페이지 목록

    @Delete("DELETE FROM worship")
    int deleteAll() throws Exception; ; // 글 전체 삭제(테스트코드용)
}
