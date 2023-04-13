/*
    작성자 : 박지원
    작성일 : 2023-04-09
*/
package com.church.service;

import com.church.domain.Praise;
import com.church.domain.SearchCondition;
import com.church.mapper.PraiseMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PraiseServiceImpl implements PraiseService {
    private final PraiseMapper praiseMapper;
    @Override
    public Praise praiseView(int pno) throws Exception {
        praiseMapper.updateViewCnt(pno);
        return praiseMapper.selectOne(pno);
    }
    @Override
    public boolean praiseRegister(Praise praise) throws Exception {
        return praiseMapper.insertPraise(praise)==1;
    }
    @Override
    public boolean praiseRemoveForAdmin(int pno) throws Exception {
        return praiseMapper.deleteForAdmin(pno)==1;
    }
    @Override
    public boolean praiseModify(Praise praise) throws Exception {
        return praiseMapper.updatePraise(praise)==1;
    }
    @Override
    public boolean praiseLikeCnt(int pno) throws Exception{
        return praiseMapper.updateLikeCnt(pno)==1;
    }
    @Override
    public List<Praise> praiseSearchPage(SearchCondition sc) throws Exception {
        return praiseMapper.selectSearchPage(sc);
    }
    @Override
    public int praiseSearchCount(SearchCondition sc) throws Exception {
        return praiseMapper.selectSearchCount(sc);
    }

    @Override
    public int count() {
        return praiseMapper.count();
    }
}
