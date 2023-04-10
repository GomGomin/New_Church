/*
    작성자 : 박지원
    작성일 : 2023-04-09
*/
package com.church.service;

import com.church.domain.Praise;
import com.church.domain.SearchCondition;

import java.util.List;

public interface PraiseService {
    Praise praiseView(int pno) throws Exception; // 게시글 한개 조회
    boolean praiseRegister(Praise praise) throws Exception; ; // 게시물 등록
    boolean praiseRemoveForAdmin(int pno) throws Exception; ; // 관리자 글 삭제
    boolean praiseModify(Praise praise) throws Exception; ; //게시글 수정
    boolean praiseLikeCnt(int pno) throws  Exception; // 좋아요 카운트 + 1
    List<Praise> praiseSearchPage(SearchCondition sc) throws Exception; // 게시물 리스트
    int praiseSearchCount(SearchCondition sc) throws Exception; // 게시물 수






}
