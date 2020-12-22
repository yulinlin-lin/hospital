package com.sgu.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.sgu.domain.Dep;
import com.sgu.service.DepService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author huang
 * @date 2020/12/8 21:40
 */
@Controller
@RequestMapping("/dep")
public class DepController {


    @Autowired
    private DepService depService;


    @ResponseBody
    @RequestMapping("/getDepsList")
    public List<Dep> queryDepsList(){
        List<Dep> deps = depService.selectList(new EntityWrapper<Dep>());
        return deps;
    }




}
