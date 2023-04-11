/*
    작성자 : 박지원
    작성일 : 2023-04-10
*/
package com.church.service;

import com.church.domain.ScheduleReply;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface ScheduleReplyService {
    int replyCount(int sno) throws Exception;
    int remove(int rno, String rwriter, int sno) throws Exception;
    int register(ScheduleReply scheduleReply) throws Exception;
    List<ScheduleReply> list(int sno) throws Exception;
    ScheduleReply view(int rno) throws Exception;
    int modify(ScheduleReply scheduleReply) throws Exception;
}
