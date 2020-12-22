package com.sgu.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sgu.domain.Dep;
import com.sgu.domain.Doctor;
import com.sgu.domain.Register;
import com.sgu.service.DepService;
import com.sgu.service.DoctorService;
import com.sgu.util.DataUtil;
import com.sgu.util.ExcelUtil;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;

/**
 * @author huang
 * @date 2020/12/15 15:03
 */
@Controller
@RequestMapping("/doctor")
public class DoctorController {


    @Autowired
    private DoctorService doctorService;

    @Autowired
    private DepService depService;


    /***
     * 根据     科室号   来查询医生的信息；   查询同一个科室中的所有的医生的信息；
     * @param depid
     * @return
     */
    @ResponseBody
    @RequestMapping("/queryByDepId")
    public List<Doctor> queryByDepId(Integer depid) {
        List<Doctor> doctors = doctorService.selectList(new EntityWrapper<Doctor>()
                .eq("depid", depid)
        );
        return doctors;
    }


    /***
     * 查询所有的医生信息；所有的都查询出来；
     * @return
     */
    @ResponseBody
    @RequestMapping("/queryAllDoctor")
    public List<Doctor> queryAllDoctor() {
        List<Doctor> doctors = doctorService.selectList(new EntityWrapper<Doctor>());
        return doctors;
    }


    /***
     * 分页查询医生信息
     * @param pageNum  当前页码
     * @param pageSize  每页显示的条数
     * @param doctorId 条件查询中的   医生I编号
     * @param name    条件查询中的医生名字
     * @param depName  条件查询中医生所有的科室名字
     * @param m
     * @return
     */
    @RequiresPermissions("doctor:index")
    @RequestMapping("/index/{pageNum}/{pageSize}")
    public String indexDoctors(@PathVariable("pageNum") Integer pageNum,
                               @PathVariable("pageSize") Integer pageSize,
                               @RequestParam(value = "doctorId", required = false) Integer doctorId,
                               @RequestParam(value = "name", required = false) String name,
                               @RequestParam(value = "depName", required = false) String depName,
                               Model m) {

        PageHelper.startPage(pageNum, pageSize);

        List<Doctor> doctors
                = doctorService.queryDoctorsByCondition(doctorId, name, depName);


        PageInfo<Doctor> pg2 = new PageInfo<Doctor>(doctors);

        m.addAttribute("pg2", pg2);

        m.addAttribute("conditionDoctorId", doctorId);
        m.addAttribute("conditionName", name);
        m.addAttribute("conditionDepName", depName);

        return "doctor/index";
    }


    /***
     *   新增一条医生信息
     * @param d   前台传递过来的医生信息
     * @return
     */
    @RequestMapping("/addDoctor")
    public String addDoctor(Doctor d) {

        /*
        Doctor(doctorId=null, name=李小明, identifierType=2,
        identifier=440982199902303698, phone=13423578943, telephone=7389609,
         gender=2, age=23, birthDate=1998-06-13, email=1009727380@qq.com,
         depid=4, degree=2, remark=这是一个妇科的大佬哦！,
         createTime=null, del=null, dep=null)
         */
        d.setCreateTime(DataUtil.getDate_YYYYMMdd());
        d.setDel(0);

        boolean insert = doctorService.insert(d);
        System.out.println("新增医生成功： " + insert);

        return "forward:/doctor/index/1/5";
    }


    /***
     *  根据医生的id来查看医生的信息
     * @param doctorId 医生id
     * @param m 模型
     * @return
     */
    @RequestMapping("/look/{doctorId}")
    public String lookdoctor(@PathVariable("doctorId") Integer doctorId, Model m) {
        Doctor doctor = doctorService.queryDoctorsById(doctorId);
        m.addAttribute("doctor", doctor);
        return "doctor/look";
    }


    /***
     *  根据医生的id来查询医生的信息并且返回这个医生的信息回到页面；
     * @param doctorId   医生id
     * @param m 模型
     * @return
     */
    @RequestMapping("/edit/{doctorId}")
    public String edit(@PathVariable("doctorId") Integer doctorId, Model m) {
        Doctor doctor = doctorService.queryDoctorsById(doctorId);
        m.addAttribute("doctor", doctor);
        return "doctor/edit";
    }


    /***
     * 真正修改医生的信息根据，医生的id;
     * @param d  前台传递过来的医生的信息
     * @return
     */
    @RequestMapping("/editBydoctorId")
    public String editBydoctorId(Doctor d) {
        System.out.println(d);
        System.out.println(d);
        System.out.println(d);

        boolean flag = doctorService.update(d, new EntityWrapper<Doctor>().eq("doctorId", d.getDoctorId()));
        System.out.println("更新是否成功：" + flag);

        return "forward:/doctor/index/1/5";
    }



    @RequestMapping("/dbExportToExcel")
    public List<Doctor> dbExportToExcel(@RequestParam(value = "doctorId", required = false) Integer doctorId,
                                          @RequestParam(value = "name", required = false) String name,
                                          @RequestParam(value = "depName", required = false) String depName,
                                          HttpServletResponse response) {

        List<Doctor> doctors
                = doctorService.queryDoctorsByCondition(doctorId, name, depName);
        for (Doctor doctor : doctors) {
            System.out.println(doctor);
        }

        /*Doctor(doctorId=5, name=彭万里111, identifierType=1,
        identifier=440982199902301111, phone=13423571111, telephone=7389111,
        gender=1, age=11, birthDate=1998-06-11 00:00:00.0, email=1009721111@qq.com,
         depid=5, degree=2, remark=此人表现优异工作非常的积极！,
         createTime=2020-12-18, del=0, dep=Dep(depId=5, depCode=0015, depName=儿科))
         */

        //        给定头信息
        String[] cells_names = {"医生编号","医生姓名","入院时间","所属科室","手机","性别","学历"};

//        给定二维数组的长度，里面存放的就是要存放内容；
        String[][] values = new String[doctors.size()][7];
        for (int i = 0; i < doctors.size(); i++) {
            Doctor d = doctors.get(i);
            values[i][0] = d.getDoctorId().toString();
            values[i][1] = d.getName();
            values[i][2] = d.getCreateTime();
            values[i][3] = d.getDep().getDepName();
            values[i][4] = d.getPhone();
            values[i][5] = d.getGender().toString();
            values[i][6] = d.getDegree().toString();
        }
        Workbook wb = ExcelUtil.getWorkbook("医生信息", cells_names, values);
        try {
            String fileName = "医生信息"+System.currentTimeMillis()+".xlsx";
            this.setResponseHeader(response, fileName);
            OutputStream os = response.getOutputStream();
            wb.write(os);//响应给客户端
            os.flush();
            os.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return doctors;

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
