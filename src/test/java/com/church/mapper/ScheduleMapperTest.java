/*
    작성자 : 박지원
    작성일 : 2023-04-05
*/
package com.church.mapper;

import com.church.domain.Schedule;
import com.church.domain.SchedulePageHandler;
import lombok.Setter;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/**/root-context.xml")
public class ScheduleMapperTest {
    @Setter(onMethod_ = @Autowired)
    private ScheduleMapper scheduleMapper;

    @Test
    public void deleteAllTest() throws Exception {
        scheduleMapper.deleteAll();
    }
    @Test
    public void insertAndUpdateTest() throws Exception {
        scheduleMapper.deleteAll();
        Schedule schedule = new Schedule("제목입니다", "글내용입니다", "asdf");
        System.out.println("inserted Schedule" + schedule);
        assert(scheduleMapper.insertSchedule(schedule) == 1);
        int sno = scheduleMapper.selectAll().get(0).getSno();
        schedule.setStitle("수정제목입니다.");
        schedule.setScontents("수정글내용입니다.");
        schedule.setSno(sno);
        System.out.println("updated Schedule" + schedule);
        assert(scheduleMapper.updateSchedule(schedule)==1);
    }
    @Test
    public void selectAllTest() throws Exception {
        List<Schedule> list = scheduleMapper.selectAll();
        System.out.println("column_cnt : " + list.size());
        assert(list!=null);
        Schedule schedule = scheduleMapper.selectOne(list.get(0).getSno());
        System.out.println(schedule);
        assert(scheduleMapper.updateViewCnt(list.get(0).getSno())==1);
        Schedule schedule2 = scheduleMapper.selectOne(list.get(0).getSno());
        System.out.println(schedule2);
    }
    @Test
    public void pagingTest(){
        SchedulePageHandler sph = new SchedulePageHandler(256,12,10);
    }
    @Test
    public void selectPageTest() throws Exception {
        scheduleMapper.deleteAll();
        for (int i = 1; i <= 256; i++) {
            Schedule schedule = new Schedule("title"+i, "no content"+i, "asdf");
            scheduleMapper.insertSchedule(schedule);
        }

        Map map = new HashMap();
        map.put("offset", 0);
        map.put("pageSize", 10);

        List<Schedule> list = scheduleMapper.selectPage(map);
        System.out.println(list.get(0).getStitle());
        System.out.println(list.get(1).getStitle());
        assert(list.get(0).getStitle().equals("title256"));
        assert(list.get(1).getStitle().equals("title255"));

    }
}
