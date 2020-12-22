package com.sgu.controller;

import com.sgu.domain.Result;
import com.sgu.domain.UserVo;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * @author huang
 * @date 2020/12/21 11:04
 */
@Controller
public class LoginController {


    @RequestMapping("/errorUI")
    public String errorUI(){
        return "error";
    }






    /*@RequestMapping("/loginUI")
    public String loginUI(){
        return "login";
    }*/
    
    @GetMapping("/login")
    public String loginUI(){
        return "login";
    }



    /***
     * 用户登录处理方法；
     * @param username
     * @param password
     * @param session
     * @return
     */
    @RequestMapping("/login")
    public String userLogin(String username, String password, HttpSession session) {
        Subject subject = SecurityUtils.getSubject();

        UsernamePasswordToken token = new UsernamePasswordToken(username, password);
        try {
            //3 让 shiro 框架进行登录验证：
            subject.login(token);
        } catch (Exception e) {
            e.printStackTrace();
            return "forward:/errorUI";
        }

        UserVo uvo = (UserVo)subject.getPrincipal();
        session.setAttribute("user",uvo);
        return "forward:/index";
    }

}
