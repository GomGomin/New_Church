package com.church.service;

import com.church.domain.ScheduleReply;
import com.church.mapper.ScheduleMapper;
import com.church.mapper.ScheduleReplyMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ScheduleReplyServiceImpl implements ScheduleReplyService {
    private final ScheduleMapper scheduleMapper;
    private final ScheduleReplyMapper scheduleReplyMapper;
    @Override
    public int replyCount(int sno) throws Exception {
        return scheduleReplyMapper.count(sno);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int remove(int rno, int sno) throws Exception {
        int cnt = scheduleMapper.updateReplyCnt(-1, sno);
        cnt = scheduleReplyMapper.delete(rno);
        return cnt;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int register(ScheduleReply scheduleReply) throws Exception {
        scheduleMapper.updateReplyCnt(1, scheduleReply.getSno());
        return scheduleReplyMapper.insert(scheduleReply);
    }

    @Override
    public List<ScheduleReply> list(int sno) throws Exception {
        return scheduleReplyMapper.selectAll(sno);
    }

    @Override
    public ScheduleReply view(int rno) throws Exception {
        return scheduleReplyMapper.select(rno);
    }

    @Override
    public int modify(ScheduleReply scheduleReply) throws Exception {
        return scheduleReplyMapper.update(scheduleReply);
    }
}
