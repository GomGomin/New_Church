package com.church.mapper;

import com.church.domain.ScheduleReply;
import lombok.Setter;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/**/root-context.xml")
public class ScheduleReplyMapperTest {
    @Setter(onMethod_ = @Autowired)
    private ScheduleReplyMapper scheduleReplyMapper;

    @Test
    public void selectPageTest() throws Exception {
        for (int i = 1; i <= 20; i++) {
            ScheduleReply scheduleReply = new ScheduleReply(2058, "asdf", "asdf" + i);
            assert (scheduleReplyMapper.insert(scheduleReply) == 1);
        }
    }
}