/*
    작성자 : 박지원
    작성일 : 2023-04-10
*/
package com.church.service;

import com.church.domain.Worship;
import com.church.domain.SearchCondition;
import com.church.mapper.WorshipMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class WorshipServiceImpl implements WorshipService {
    private final WorshipMapper worshipMapper;
    @Override
    public Worship worshipView(int wno) throws Exception {
        worshipMapper.updateViewCnt(wno);
        return worshipMapper.selectOne(wno);
    }
    @Override
    public boolean worshipRegister(Worship worship) throws Exception {
        return worshipMapper.insertworship(worship)==1;
    }
    @Override
    public boolean worshipRemoveForAdmin(int wno) throws Exception {
        return worshipMapper.deleteForAdmin(wno)==1;
    }
    @Override
    public boolean worshipModify(Worship worship) throws Exception {
        return worshipMapper.updateworship(worship)==1;
    }
    @Override
    public List<Worship> worshipSearchPage(SearchCondition sc) throws Exception {
        return worshipMapper.selectSearchPage(sc);
    }
    @Override
    public int worshipSearchCount(SearchCondition sc) throws Exception {
        return worshipMapper.selectSearchCount(sc);
    }

    @Override
    public int count() {
        return worshipMapper.count();
    }
}
