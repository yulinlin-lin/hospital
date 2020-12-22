package com.sgu.test;

import com.sgu.mapper.UsersMapper;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;
import java.util.Map;

/**
 * @author huang
 * @date 2020/12/21 15:04
 */
public class Apptest2 {



    @Test
    public void test1(){

        ClassPathXmlApplicationContext ac
                = new ClassPathXmlApplicationContext("classpath:spring-mybatis.xml");
        UsersMapper u =  (UsersMapper)ac.getBean("usersMapper");
        List<String> list = u.queryUsersAllMenus(9);
        for (String s : list) {
            System.out.println(s);
        }


        /*List<Map<String, Object>> maps = u.queryUsersMenus(9);
        System.out.println(maps);
*/
    }


}
