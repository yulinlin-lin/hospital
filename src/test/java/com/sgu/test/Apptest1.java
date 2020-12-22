package com.sgu.test;

/**
 * @author huang
 * @date 2020/12/7 22:54
 */

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.sgu.domain.*;
import com.sgu.mapper.*;
import com.sgu.service.DepService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-mybatis.xml")
public class Apptest1 {

    @Autowired
    private RegisterMapper registerMapper;


    @Autowired
    private DepService depService;


    @Autowired
    private DoctorMapper doctorMapper;

    @Autowired
    private DrugsMapper drugsMapper;

    @Autowired
    private UsersMapper usersMapper;

    @Autowired
    private RoleMapper roleMapper;

    @Test
    public void test1() {

        List<Map<String, Object>> maps = usersMapper.queryUsersMenus(9);
        System.out.println(maps);

    }

}
