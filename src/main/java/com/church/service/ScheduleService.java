package com.church.service;

import com.church.domain.Schedule;

import java.util.List;
import java.util.Map;

public interface ScheduleService {
    boolean scheduleReplyCnt(int replyCount); // ReplyMapper에서 sno카운트한 값 넣기
    int scheduleTotalCnt(); // 총 게시글 수
    List<Schedule> schedulePageList(Map map); //한 페이지의 게시글 목록
    List<Schedule> scheduleAll(); //게시글 전체 목록
    Schedule scheduleView(int sno); // 게시글 한개 조회
    boolean scheduleRegister(Schedule schedule); // 게시물 등록
    boolean scheduleRemoveForAdmin(int sno); // 관리자 글 삭제
    boolean scheduleRemove(Map map); // 유저 글 삭제
    boolean scheduleModify(Schedule schedule); //게스글 수정
    boolean scheduleViewCnt(int sno); //조회수 카운트 + 1







}
