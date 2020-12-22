package com.sgu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author huang
 * @date 2020/12/9 12:51
 */
@Controller
public class IndexController {




    @RequestMapping("/index")
    public String getIndex(){
        return "index";
    }



    
}
