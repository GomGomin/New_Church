/*
    작성자 : 박지원
    작성일 : 2023-04-10
*/

package com.church.mapper;

import com.church.domain.ScheduleReply;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ScheduleReplyMapper {
    int delete(@Param("rno") int rno, @Param("rwriter") String rwriter) throws Exception;
    int deleteAll(int sno) throws Exception;
    ScheduleReply select(int rno) throws Exception;
    List<ScheduleReply> selectAll(int sno) throws Exception;
    int insert(ScheduleReply scheduleReply) throws Exception;
    int update(ScheduleReply scheduleReply) throws Exception;
    int count(int sno) throws Exception;

}
