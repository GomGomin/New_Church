/*
    작성자 : 박지원
    작성일 : 2023-04-09
*/

package com.church.mapper;

import com.church.domain.Praise;
import com.church.domain.SearchCondition;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface PraiseMapper {
    @Select("SELECT * FROM praise WHERE pno = #{pno}") // 게시글 한개 조회
    Praise selectOne(int pno) throws Exception; ;
    @Insert("INSERT INTO praise" +
                " (ptitle,pcontents,pwriter)" +
            " VALUES" +
                " (#{ptitle},#{pcontents},#{pwriter})")
    int insertPraise(Praise praise) throws Exception; ; // 게시물 등록
    @Delete("DELETE FROM praise WHERE pno = #{pno}")
    int deleteForAdmin(int pno) throws Exception; ; // 글 삭제 (관리자)
    @Delete("DELETE FROM praise")
    int deleteAll() throws Exception; ; // 글 전체 삭제(테스트코드용)
    @Update("UPDATE praise" +
            " SET ptitle = #{ptitle}, pcontents = #{pcontents}" +
            " WHERE pno = #{pno}")
    int updatePraise(Praise praise) throws Exception; ; //게시글 수정
    @Update("UPDATE praise" +
            " SET pview = pview + 1" +
            " WHERE pno = #{pno}")
    int updateViewCnt(int pno) throws Exception; ; //조회수 카운트 + 1
    @Update("UPDATE praise" +
            " SET pview = pview + 1" +
            " WHERE pno = #{pno}")  
    int updateLikeCnt(int pno) throws  Exception; // 좋아요 카운트  + 1
    int selectSearchCount(SearchCondition sc) throws Exception; ; //키워드 검색 포함 게시물 수
    List<Praise> selectSearchPage(SearchCondition sc) throws Exception; ; //키워드 검색 포함 페이지 목록
}
