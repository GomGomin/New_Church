//작성자 : 심현민
//최초 작성일 : 23.04.04
package com.church.service;

import java.util.List;

import com.church.domain.Notice;
import com.church.mapper.NoticeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    NoticeMapper noticeMapper;

    @Override
    public void newNotice(Notice notice) {
        noticeMapper.newNotice(notice);
    }

    @Override
    public int count() {
        return noticeMapper.count();
    }

    @Override
    public Notice noticeById(int nno) {
        return noticeMapper.noticeById(nno);
    }

    @Override
    public void editNotice(Notice notice) {
        noticeMapper.editNotice(notice);
    }

    @Override
    public void updateView(int nno) {
        noticeMapper.updateView(nno);
    }

    @Override
    public void removeNotice(String nno) {
        noticeMapper.removeNotice(nno);
    }

    @Override
    public List<Notice> list(int displayPost, int postNum, String searchType, String keyword) throws Exception {
        return noticeMapper.list(displayPost, postNum, searchType, keyword);
    }

    @Override
    public int searchCount(String searchType, String keyword) throws Exception {
        return noticeMapper.searchCount(searchType, keyword);
    }

}