package com.sgu.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sgu.domain.*;
import com.sgu.service.UserARoleService;
import com.sgu.service.UsersService;
import com.sgu.util.DataUtil;
import com.sgu.util.ExcelUtil;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;

/**
 * @author huang
 * @date 2020/12/8 22:43
 */
@Controller
@RequestMapping("/user")
public class UsersController {


    @Autowired
    private UsersService usersService;


    @Autowired
    private UserARoleService userARoleService;




    @RequestMapping("/dbExportToExcel")
    public List<Users> dbExportToExcel(@RequestParam(value = "realname", required = false) String realname,
                                       HttpServletResponse response) {
        List<Users> users = usersService.queryUsersByCondition(realname);


        //        给定头信息
        String[] cells_names = {"用户登录名","真实姓名","角色","邮箱"};

//        给定二维数组的长度，里面存放的就是要存放内容；
        String[][] values = new String[users.size()][4];
        for (int i = 0; i < users.size(); i++) {

            Users u = users.get(i);
            values[i][0] = u.getNo();
            values[i][1] = u.getRealname();
            values[i][2] = u.getRole().getRoleName();
            values[i][3] = u.getEmail();
        }

        Workbook wb = ExcelUtil.getWorkbook("用户列表信息", cells_names, values);
        try {
            String fileName = "用户列表信息"+System.currentTimeMillis()+".xlsx";
            this.setResponseHeader(response, fileName);
            OutputStream os = response.getOutputStream();
            wb.write(os);//响应给客户端
            os.flush();
            os.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }


    /**
     * 发送响应流方法
     */
    public void setResponseHeader(HttpServletResponse response, String fileName) {
        try {
            try {
                fileName = new String(fileName.getBytes(), "ISO8859-1");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            //1 、只能提交二进制，而且只能提交一个二进制，如果提交文件的话，只能提交一个文件,后台接收参数只能有一个，而且只能是流（或者字节数组）
            //2、属于HTTP规范中Content-Type的一种
            response.setContentType("application/octet-stream;charset=ISO8859-1");
            //Content-Disposition是以什么方式下载，如attachment为以附件方式下载
            response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
            response.addHeader("Pargam", "no-cache");//设置网页不要存于缓存中
            response.addHeader("Cache-Control", "no-cache");//告知服务器不直接使用缓存，要求向原服务器发起请求
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }


    @RequestMapping("/index/{pageNum}/{pageSize}")
    public String indexUsers(@PathVariable("pageNum") Integer pageNum,
                             @PathVariable("pageSize") Integer pageSize,
                             @RequestParam(value = "realname", required = false) String realname,
                             Model m) {
        PageHelper.startPage(pageNum, pageSize);
        List<Users> users = usersService.queryUsersByCondition(realname);
        PageInfo<Users> pg4 = new PageInfo<Users>(users);
        m.addAttribute("pg4", pg4);
        m.addAttribute("real", realname);
        return "user/userindex";
    }


    @RequestMapping("/addUser")
    public String addUser(Users u, Integer roleid) {
        u.setCreateTime(DataUtil.getDate_YYYYMMdd());
//        System.out.println(u);
//        System.out.println(roleid);

//        Users(userid=null, no=mww, password=123, realname=莫文蔚, email=1009727380@qq.com,
//        status=0, del=null, modifytime=null, createTime=null, role=null)
        boolean insert = usersService.insert(u);
        System.out.println("新增成功：  " + insert);

        UserARole ur = new UserARole();
        ur.setRoleId(roleid);
        ur.setUserId(u.getUserid());
        boolean insert1 = userARoleService.insert(ur);
        System.out.println("新增那个关系成功：   " + insert1);

        return "forward:/user/index/1/5";
    }


    @GetMapping("/editUser")
    public String selectUserById(Integer userid, Model m) {
        Users u = usersService.queryOneById(userid);
        m.addAttribute("u", u);
        return "user/editUser";
    }


    @PostMapping("/editUser")
    public String editUser(Users u,
                           @RequestParam("rid") Integer rid,
                           @RequestParam("oldroleid") Integer oldroleid) {
        System.out.println(u);
        System.out.println(rid);
        System.out.println(oldroleid);

        boolean userid = usersService.update(u, new EntityWrapper<Users>().eq("userid", u.getUserid()));
        System.out.println("更新用户：  " + userid);

        boolean update = userARoleService.updateUserRoleId(u.getUserid(), rid, oldroleid);
        System.out.println("更新用户的角色是否成功：   " + userid);
        return "forward:/user/index/1/5";
    }


    @ResponseBody
    @PostMapping("/deleteUser")
    public Result deleteUser(Integer userid) {
        System.out.println("删除； " + userid);

        Result result = null;
        Users u = new Users();
        u.setUserid(userid);
        u.setDel(1);
        boolean b = usersService.updateById(u);

        if (b) {
            result = new Result(0, "删除成功！");
        } else {
            result = new Result(500, "删除失败！");
        }

        return result;
    }
    
    
    
    @RequestMapping("/passRestPage")
    public String passRestPage(){
        return "user/passrest";
    }

    @ResponseBody
    @PostMapping("/passRest")
    public Result passRest(String oldPass,
                           String newPass,
                           Integer userid,
                           HttpSession session) {
        Result result = null;

        Users u = new Users();
        u.setPassword(newPass);

        boolean update = usersService.update(u, new EntityWrapper<Users>().eq("userid", userid).eq("password", oldPass));
        if(update){
            result = new Result(0,"修改成功！");
        }else{
            result = new Result(500,"原密码错误！");
        }
        return result;
    }


}
