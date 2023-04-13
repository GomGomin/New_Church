/*
    작성자 : 박지원
    작성일 : 2023-04-10
*/
package com.church.service;

import com.church.domain.SearchCondition;
import com.church.domain.Event;
import com.church.mapper.EventMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class EventServiceImpl implements EventService {
    private final EventMapper eventMapper;
    @Override
    public Event eventView(int eno) throws Exception {
        eventMapper.updateViewCnt(eno);
        return eventMapper.selectOne(eno);
    }
    @Override
    public boolean eventRegister(Event event) throws Exception {
        return eventMapper.insertevent(event)==1;
    }
    @Override
    public boolean eventRemoveForAdmin(int eno) throws Exception {
        return eventMapper.deleteForAdmin(eno)==1;
    }
    @Override
    public boolean eventModify(Event event) throws Exception {
        return eventMapper.updateevent(event)==1;
    }
    @Override
    public List<Event> eventSearchPage(SearchCondition sc) throws Exception {
        return eventMapper.selectSearchPage(sc);
    }
    @Override
    public int eventSearchCount(SearchCondition sc) throws Exception {
        return eventMapper.selectSearchCount(sc);
    }

    @Override
    public int count() {
        return eventMapper.count();
    }
}
