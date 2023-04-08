/*
    작성자 : 박지원
    작성일 : 2023-04-05
*/
package com.church.service;

import com.church.domain.Schedule;
import com.church.domain.SearchCondition;
import com.church.mapper.ScheduleMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
@Service
@RequiredArgsConstructor
public class ScheduleServiceImpl implements ScheduleService {
    private final ScheduleMapper scheduleMapper;
    @Override
    public boolean scheduleReplyCnt(int replyCount) throws Exception {
        return scheduleMapper.insertReplyCnt(replyCount)==1;
    }

    @Override
    public int scheduleTotalCnt() throws Exception{
        return scheduleMapper.selectCountBoard();
    }

    @Override
    public List<Schedule> schedulePageList(Map map) throws Exception{
        return scheduleMapper.selectPage(map);
    }

    @Override
    public List<Schedule> scheduleAll() throws Exception {
        return scheduleMapper.selectAll();
    }

    @Override
    public Schedule scheduleView(int sno) throws Exception {
        scheduleMapper.updateViewCnt(sno);
        return scheduleMapper.selectOne(sno);
    }

    @Override
    public boolean scheduleRegister(Schedule schedule) throws Exception {
        return scheduleMapper.insertSchedule(schedule)==1;
    }

    @Override
    public boolean scheduleRemoveForAdmin(int sno) throws Exception {
        return scheduleMapper.deleteForAdmin(sno)==1;
    }

    @Override
    public boolean scheduleRemove(Map map) throws Exception {
        return scheduleMapper.deleteSchedule(map)==1;
    }

    @Override
    public boolean scheduleModify(Schedule schedule) throws Exception {
        return scheduleMapper.updateSchedule(schedule)==1;
    }

    @Override
    public boolean scheduleViewCnt(int sno) throws Exception{
        return scheduleMapper.updateViewCnt(sno)==1;
    }

    @Override
    public List<Schedule> scheduleSearchPage(SearchCondition sc) throws Exception {
        return scheduleMapper.selectSearchPage(sc);
    }
    @Override
    public int scheduleSearchCount(SearchCondition sc) throws Exception {
        return scheduleMapper.selectSearchCount(sc);
    }
}
