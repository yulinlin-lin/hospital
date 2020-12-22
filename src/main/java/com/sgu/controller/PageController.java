package com.sgu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author huang
 * @date 2020/12/14 21:05
 */
@Controller
@RequestMapping("/topage")
public class PageController {


    @RequestMapping("/registration/{page}")
    public String methodName(@PathVariable("page") String page){
        System.out.println("================== :        "+page);
        page = "registration/"+page;
        return page;
    }


    /***
     * 医生专用的跳转页面方法
     * @param page
     * @return
     */
    @RequestMapping("/doctor/{page}")
    public String doctortoPage(@PathVariable("page") String page){
        page = "doctor/"+page;
        return page;
    }



    @RequestMapping("/drug/{page}")
    public String drugtoPage(@PathVariable("page") String page){
        page = "drug/"+page;
        return page;
    }



    @RequestMapping("/user/{page}")
    public String usertoPage(@PathVariable("page") String page){
        page = "user/"+page;
        return page;
    }



    @RequestMapping("/role/{page}")
    public String roletoPage(@PathVariable("page") String page){
        page = "role/"+page;
        return page;
    }



    @RequestMapping("/resource/{page}")
    public String resourcetoPage(@PathVariable("page") String page){
        page = "resource/"+page;
        return page;
    }

}
