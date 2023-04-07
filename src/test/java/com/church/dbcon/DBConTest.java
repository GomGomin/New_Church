/*
    작성자 : 박지원
    작성일 : 2023-04-04
*/
package com.church.dbcon;


import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/**/root-context.xml")
public class DBConTest {

    @Autowired
    private DataSource ds;
    @Autowired
    private SqlSessionFactory sqlSessionFactory;

    @Test
    public void myBatisTest(){
        SqlSession sqlsession = sqlSessionFactory.openSession();
        Connection conn = sqlsession.getConnection();
        System.out.println("sqlSession : " + sqlsession);
        System.out.println("conn : " + conn);
        assert (sqlsession!=null && conn != null);
    }
    @Test
    public void dbConTest(){
        try (Connection conn = ds.getConnection()){
            System.out.println("conn : " + conn);
            assert (conn!=null);
        } catch (SQLException e) {
            System.out.println("exception : " + e);
            assert(false);
        }

    }

}
