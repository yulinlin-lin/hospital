package com.sgu.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sgu.domain.Register;
import com.sgu.domain.Result;
import com.sgu.service.RegisterService;
import com.sgu.util.DataUtil;
import com.sgu.util.ExcelUtil;
import com.sgu.util.IdBuilder;
import com.sun.org.apache.regexp.internal.RE;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

/**
 * 挂号信息处理控制 类
 *
 * @author huang
 * @date 2020/12/9 12:55
 */
//@Controller

@Controller
@RequestMapping("/registration")
public class RegistrationController {

    @Autowired
    private RegisterService registerService;

    /***
     * 返回挂号信息首页面
     * @return
     */
    @RequiresPermissions("registration:index")
    @RequestMapping("/index/{pageNum}/{pageSize}")
    public String index(@PathVariable("pageNum") Integer pageNum,
                        @PathVariable("pageSize") Integer pageSize,
                        @RequestParam(value = "bingLiId", required = false, defaultValue = "") String bingLiId,
                        @RequestParam(value = "doctorName", required = false) String doctorName,
                        @RequestParam(value = "depName", required = false) String depName,
                        @RequestParam(value = "startCreateTime", required = false) String startCreateTime,
                        @RequestParam(value = "endCreateTime", required = false) String endCreateTime,
                        Model m) {

        PageHelper.startPage(pageNum, pageSize);

        List<Register> registers =
                registerService.queryRegisterByPage(bingLiId,
                        doctorName,
                        depName,
                        startCreateTime,
                        endCreateTime);

        PageInfo<Register> pg1 = new PageInfo(registers);

        m.addAttribute("pg1", pg1);

        m.addAttribute("bingLiId",bingLiId);
        m.addAttribute("doctorName",doctorName);
        m.addAttribute("depName",depName);
        m.addAttribute("startCreateTime",startCreateTime);
        m.addAttribute("endCreateTime",endCreateTime);

        return "registration/index";
    }



    /*
    Register(bingLiId=null, name=明, identifierType=身份证, identifier=12121212,
    insuranceint=12121212, phone=13423578943, expenseFlag=是, gender=1, age=12,
    profession=程序员, czflag=初诊, doctorId=1, modifyTime=null, createTime=null,
    status=null, remark=花木成畦手自栽基本面, guahaofei=123.0, del=null, d=null, dep=null)
     */


    /***
     * 插入一条挂号信息处理的方法
     * @param register
     * @return
     */
    @RequestMapping("/addRegister")
    public String addRegister(Register register){
        System.out.println(register);

        String bliid = IdBuilder.getRegistrationID();
        register.setBingLiId(bliid);  // 设置病历号
        register.setCreateTime(DataUtil.getDate_YYYYMMdd());   // 设置创建时间
        register.setStatus(1);  // 设置状态   该状态是已挂号
        register.setDel(0);  // 设置删除的状态

        boolean insert = registerService.insert(register);
        System.out.println("插入是否成功：  "+insert);
        return "forward:/registration/index/1/5";
    }


    /***
     * 查看挂号信息通过id；
     * @param id
     * @param m
     * @return
     */
    @RequestMapping("/queryRegisterById")
    public String queryRegisterById(String id,Model m){
        System.out.println("要查看的id:   "+id);

        Register register = registerService.queryRegisterByBlindId(id);

        m.addAttribute("reg",register);

        return "registration/look";
    }



    @RequestMapping("/editRegisterById")
    public String editRegisterById(String id,Model m){
        System.out.println("要查看的id:   "+id);
        Register register = registerService.queryRegisterByBlindId(id);
        m.addAttribute("regedit",register);
        return "registration/edit";
    }

    
    @RequestMapping("/updateRegister")
    public String updateRegister(Register reg){
        System.out.println(reg);
        boolean b = registerService.update(reg,new EntityWrapper<Register>().eq("bingLiId",reg.getBingLiId()));
        return "forward:/registration/index/1/5";
    }


    /***
     * 单个进行退号操作
     * @param id   病例号ID    根据病例号ID来进行修改退号操作
     * @return
     */
    @RequestMapping("/Bounce")
    public String Bounce(String id){
        Register register = new Register();
        register.setStatus(4);
        registerService.update(register,new EntityWrapper<Register>().eq("bingLiId",id));
        return "forward:/registration/index/1/5";
    }


    /***
     * 批量进行退号操作
     * @param idds   传递一个病例号字符串，要根据逗号来进行分割成为一个集合
     * @return
     */
    @ResponseBody
    @RequestMapping("/BounceMore")
    public Result BounceMore(String idds){
        System.out.println("传递的： "+idds);

        Result result = null;

                List<String> list = new ArrayList<>();
        String[] split = idds.split(",");
        for (String s : split) {
            list.add(s);
        }

        boolean falg = registerService.updateMoreBounceByList(list);

        if(falg){
            result = new Result(0,"修改成功！");
        }else{
            result = new Result(500,"修改失败！");
        }
        return result;
    }
    
    
    @RequestMapping("/dbExportToExcel")
    public List<Register> dbExportToExcel(@RequestParam(value = "bingLiId", required = false, defaultValue = "") String bingLiId,
                                  @RequestParam(value = "doctorName", required = false) String doctorName,
                                  @RequestParam(value = "depName", required = false) String depName,
                                  @RequestParam(value = "startCreateTime", required = false) String startCreateTime,
                                  @RequestParam(value = "endCreateTime", required = false) String endCreateTime,
                                  HttpServletResponse response){

        List<Register> registers =
                registerService.queryRegisterByPage(bingLiId,
                        doctorName,
                        depName,
                        startCreateTime,
                        endCreateTime);

        for (Register register : registers) {
            System.out.println(register);
        }

//        给定头信息
        String[] cells_names = {"病例号","挂号时间","挂号科室","挂号病人姓名"};

//        给定二维数组的长度，里面存放的就是要存放内容；
        String[][] values = new String[registers.size()][4];

        for (int i = 0; i < registers.size(); i++) {
            Register r = registers.get(i);
            values[i][0] = r.getBingLiId();
            values[i][1] = r.getCreateTime();
            values[i][2] = r.getDep().getDepName();
            values[i][3] = r.getName();
        }

        Workbook wb = ExcelUtil.getWorkbook("病例汇总", cells_names, values);


        try {
            String fileName = "病人挂号信息"+System.currentTimeMillis()+".xlsx";
            this.setResponseHeader(response, fileName);
            OutputStream os = response.getOutputStream();
            wb.write(os);//响应给客户端
            os.flush();
            os.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return registers;
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



}
