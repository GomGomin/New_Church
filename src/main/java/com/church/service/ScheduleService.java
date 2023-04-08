/*
    작성자 : 박지원
    작성일 : 2023-04-05
*/
package com.church.service;

import com.church.domain.Schedule;
import com.church.domain.SearchCondition;

import java.util.List;
import java.util.Map;

public interface ScheduleService {
    boolean scheduleReplyCnt(int replyCount) throws Exception; ; // int replyCpunt -> ReplyMapper에서 sno카운트한 값 넣기
    int scheduleTotalCnt() throws Exception; // 총 게시글 수
    List<Schedule> schedulePageList(Map map) throws Exception; ; //한 페이지의 게시글 목록
    List<Schedule> scheduleAll() throws Exception; //게시글 전체 목록
    Schedule scheduleView(int sno) throws Exception; // 게시글 한개 조회
    boolean scheduleRegister(Schedule schedule) throws Exception; ; // 게시물 등록
    boolean scheduleRemoveForAdmin(int sno) throws Exception; ; // 관리자 글 삭제
    boolean scheduleRemove(Map map) throws Exception; ; // 유저 글 삭제
    boolean scheduleModify(Schedule schedule) throws Exception; ; //게시글 수정
    boolean scheduleViewCnt(int sno) throws Exception; ; //조회수 카운트 + 1
    List<Schedule> scheduleSearchPage(SearchCondition sc) throws Exception;
    int scheduleSearchCount(SearchCondition sc) throws Exception;






}
