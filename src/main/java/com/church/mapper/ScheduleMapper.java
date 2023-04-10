/*
    작성자 : 박지원
    작성일 : 2023-04-05
*/

package com.church.mapper;

import com.church.domain.Schedule;
import com.church.domain.SearchCondition;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

public interface ScheduleMapper {
    @Update("UPDATE schedule" +
            " SET replyCount = replyCount + #{cnt}" +
            " WHERE sno = #{sno}")
    int updateReplyCnt(@Param("cnt") int cnt, @Param("sno") int sno) throws Exception; // 댓글 수
    @Select("SELECT count(*) FROM schedule")
    int selectCountBoard() throws Exception; ; //총 게시글 수
    @Select("SELECT *" +
            " FROM schedule" +
            " ORDER BY date DESC, sno DESC" +
            " LIMIT #{offset}, #{pageSize}")
    List<Schedule> selectPage(Map map) throws Exception; ; //한 페이지의 게시글 목록
    @Select("SELECT *" +
            " FROM schedule" +
            " ORDER BY date DESC, sno DESC")
    List<Schedule> selectAll() throws Exception; ; // 게시글 전체 목록
    @Select("SELECT * FROM schedule WHERE sno = #{sno}") // 게시글 한개 조회
    Schedule selectOne(int sno) throws Exception; ;
    @Insert("INSERT INTO schedule" +
                " (stitle,scontents,swriter)" +
            " VALUES" +
                " (#{stitle},#{scontents},#{swriter})")
    int insertSchedule(Schedule schedule) throws Exception; ; // 게시물 등록
    @Delete("DELETE FROM schedule WHERE sno = #{sno}")
    int deleteForAdmin(int sno) throws Exception; ; // 글 삭제 (관리자)
    @Delete("DELETE FROM schedule WHERE sno = #{sno} and swriter = #{swriter}")
    int deleteSchedule(Map map) throws Exception; ; //글 삭제(유저)
    @Delete("DELETE FROM schedule")
    int deleteAll() throws Exception; ; // 글 전체 삭제(테스트코드용)
    @Update("UPDATE schedule" +
            " SET stitle = #{stitle}, scontents = #{scontents}" +
            " WHERE sno = #{sno}")
    int updateSchedule(Schedule schedule) throws Exception; ; //게시글 수정
    @Update("UPDATE schedule" +
            " SET sview = sview + 1" +
            " WHERE sno = #{sno}")
    int updateViewCnt(int sno) throws Exception; ; //조회수 카운트 + 1

    int selectSearchCount(SearchCondition sc) throws Exception; ; //키워드 검색 게시물 수
    List<Schedule> selectSearchPage(SearchCondition sc) throws Exception; ; //키워드 검색 페이지 목록
}
