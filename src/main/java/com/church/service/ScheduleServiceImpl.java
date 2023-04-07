package com.church.service;

import com.church.domain.Schedule;
import com.church.mapper.ScheduleMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ScheduleServiceImpl implements ScheduleService {
    private ScheduleMapper scheduleMapper;

    @Override
    public boolean scheduleReplyCnt(int replyCount) {
        return scheduleMapper.insertReplyCnt(replyCount)==1;
    }

    @Override
    public int scheduleTotalCnt() {
        return scheduleMapper.selectCountBoard();
    }

    @Override
    public List<Schedule> schedulePageList(Map map) {
        return scheduleMapper.selectPage(map);
    }

    @Override
    public List<Schedule> scheduleAll() {
        return scheduleMapper.selectAll();
    }

    @Override
    public Schedule scheduleView(int sno) {
        return scheduleMapper.selectOne(sno);
    }

    @Override
    public boolean scheduleRegister(Schedule schedule) {
        return scheduleMapper.insertSchedule(schedule)==1;
    }

    @Override
    public boolean scheduleRemoveForAdmin(int sno) {
        return scheduleMapper.deleteForAdmin(sno)==1;
    }

    @Override
    public boolean scheduleRemove(Map map) {
        return scheduleMapper.deleteSchedule(map)==1;
    }

    @Override
    public boolean scheduleModify(Schedule schedule) {
        return scheduleMapper.updateSchedule(schedule)==1;
    }

    @Override
    public boolean scheduleViewCnt(int sno) {
        return scheduleMapper.updateViewCnt(sno)==1;
    }
}
