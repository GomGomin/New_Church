/*
    작성자 : 박지원
    작성일 : 2023-04-10
*/
package com.church.service;

import com.church.domain.Worship;
import com.church.domain.SearchCondition;

import java.util.List;

public interface WorshipService {
    Worship worshipView(int wno) throws Exception; // 게시글 한개 조회
    boolean worshipRegister(Worship worship) throws Exception; ; // 게시물 등록
    boolean worshipRemoveForAdmin(int wno) throws Exception; ; // 관리자 글 삭제
    boolean worshipModify(Worship worship) throws Exception; ; //게시글 수정
    List<Worship> worshipSearchPage(SearchCondition sc) throws Exception; // 게시물 리스트
    int worshipSearchCount(SearchCondition sc) throws Exception; // 게시물 수
    int count();





}
