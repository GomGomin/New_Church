/*
    작성자 : 박지원
    작성일 : 2023-04-05
*/
package com.church.mapper;

import com.church.domain.Worship;
import lombok.Setter;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/**/root-context.xml")
public class WorshipMapperTest {
    @Setter(onMethod_ = @Autowired)
    private WorshipMapper worshipMapper;

    @Test
    public void selectPageTest() throws Exception {
        worshipMapper.deleteAll();
        for (int i = 1; i <= 256; i++) {
            Worship worship = new Worship("title"+i, "no content"+i, "asdf");
            assert (worshipMapper.insertworship(worship) == 1);
        }
    }
}
