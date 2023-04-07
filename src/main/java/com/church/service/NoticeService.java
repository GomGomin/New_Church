//작성자 : 심현민
//최초 작성일 : 23.04.04
package com.church.service;

import java.util.List;

import com.church.domain.Notice;

public interface NoticeService {

    void newNotice(Notice notice);

    int count();

    public List<Notice> list(int displayPost, int postNum, String searchType, String keyword) throws Exception;

    public int searchCount(String searchType, String keyword) throws Exception;

    Notice noticeById(String nno);

    void editNotice(Notice notice);

    void updateView(String nno);

    void removeNotice(String nno);
}