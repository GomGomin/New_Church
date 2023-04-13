/*
    작성자 : 박지원
    작성일 : 2023-04-10
*/
package com.church.service;

import com.church.domain.Event;
import com.church.domain.SearchCondition;

import java.util.List;

public interface EventService {
    Event eventView(int eno) throws Exception; // 게시글 한개 조회
    boolean eventRegister(Event event) throws Exception; ; // 게시물 등록
    boolean eventRemoveForAdmin(int eno) throws Exception; ; // 관리자 글 삭제
    boolean eventModify(Event event) throws Exception; ; //게시글 수정
    List<Event> eventSearchPage(SearchCondition sc) throws Exception; // 게시물 리스트
    int eventSearchCount(SearchCondition sc) throws Exception; // 게시물 수
    int count();





}
