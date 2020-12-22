package com.sgu.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sgu.domain.*;
import com.sgu.service.ResourcesService;
import com.sgu.service.RoleResourcesService;
import com.sgu.service.RoleService;
import com.sgu.util.ExcelUtil;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author huang
 * @date 2020/12/18 19:10
 */
@Controller
@RequestMapping("/role")
public class RoleController {


    @Autowired
    private RoleService roleService;


    @Autowired
    private RoleResourcesService roleResourcesService;


    @Autowired
    private ResourcesService resourcesService;


    @ResponseBody
    @RequestMapping("/getALlRole")
    public List<Role> getALlRole() {
        List<Role> roles = roleService.selectList(new EntityWrapper<Role>());
        return roles;
    }


    @RequestMapping("/dbExportToExcel")
    public List<Role> dbExportToExcel(@RequestParam(value = "rolename", required = false) String rolename,
                                      HttpServletResponse response) {
        List<Role> roles = roleService.queryRolesByConditions(rolename);


        //        给定头信息
        String[] cells_names = {"角色名称", "角色id", "角色是否已经被删除（1是  0否）", "角色是否禁用状态（0否， 1是）"};

//        给定二维数组的长度，里面存放的就是要存放内容；
        String[][] values = new String[roles.size()][4];
        for (int i = 0; i < roles.size(); i++) {

            Role r = roles.get(i);
            values[i][0] = r.getRoleName();
            values[i][1] = r.getRoleId().toString();
            values[i][2] = r.getDel().toString();
            values[i][3] = r.getStatus().toString();
        }

        Workbook wb = ExcelUtil.getWorkbook("角色列表信息", cells_names, values);
        try {
            String fileName = "角色列表信息" + System.currentTimeMillis() + ".xlsx";
            this.setResponseHeader(response, fileName);
            OutputStream os = response.getOutputStream();
            wb.write(os);//响应给客户端
            os.flush();
            os.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roles;
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


    @RequiresPermissions("role:index")
    @RequestMapping("/index/{pageNum}/{pageSize}")
    public String indexRoles(@PathVariable("pageNum") Integer pageNum,
                             @PathVariable("pageSize") Integer pageSize,
                             @RequestParam(value = "rolename", required = false) String rolename,
                             Model m) {

        PageHelper.startPage(pageNum, pageSize);

//        List<Role> roles = null;
        List<Role> roles = roleService.queryRolesByConditions(rolename);

        PageInfo<Role> pg5 = new PageInfo<Role>(roles);
        m.addAttribute("pg5", pg5);
        m.addAttribute("rolename", rolename);
        return "role/index";
    }


    @ResponseBody
    @RequestMapping("/add")
    public Result add(String rolename, String idAll, Integer status) {
        Result result = null;
        Role role = new Role();
        role.setRoleName(rolename);
        role.setStatus(status);
        boolean flag1 = roleService.insert(role);

        List<RoleResources> list = new ArrayList<>();
        String[] IdAll = idAll.split(",");

        for (String ids : IdAll) {
            RoleResources res = new RoleResources();
            res.setRoleId(role.getRoleId());
            res.setResId(Integer.valueOf(ids));
            list.add(res);
        }

        boolean flag2 = roleResourcesService.insertBatch(list);
        if (flag1 && flag2) {
            result = new Result(0, "角色和资源绑定添加成功");
        } else {
            System.out.println("添加角色： " + flag1);
            System.out.println("添加绑定资源： " + flag2);
            result = new Result(500, "添加失败");
        }
        return result;
    }


    @GetMapping("/editRole")
    public String queryRoleById(Integer roleid, Model m) {
        System.out.println(roleid);
        Role role = roleService.queryOneById(roleid);
        m.addAttribute("role", role);
        return "role/editRole";
    }


    @ResponseBody
    @PostMapping("/edit")
    public Result editRole(String rolename, String idAll, Integer status, Integer roleId) {
        System.out.println(roleId);
        System.out.println(roleId);

        Result result = null;
        Role role = new Role();
        role.setRoleId(roleId);
        role.setRoleName(rolename);
        role.setStatus(status);
        boolean flag1 = roleService.updateById(role);


        List<RoleResources> list = new ArrayList<>();
        String[] IdAll = idAll.split(",");
        for (String ids : IdAll) {
            RoleResources res = new RoleResources();
            res.setRoleId(roleId);
            res.setResId(Integer.valueOf(ids));
            list.add(res);
        }


        if (roleId != null && roleId != 0) {
            int i = roleResourcesService.deleteMore(roleId);
            System.out.println("进行了删除：   " + i);
        }


        boolean flag2 = roleResourcesService.insertBatch(list);
        if (flag1 && flag2) {
            result = new Result(0, "角色和资源绑定修改成功");
        } else {
            System.out.println("修改角色： " + flag1);
            System.out.println("修改绑定资源： " + flag2);
            result = new Result(500, "添加失败");
        }


        return result;
    }


    @ResponseBody
    @PostMapping("/deleteById")
    public Result deleteById(Integer roleid) {

        Result result = null;

        Role role = new Role();
        role.setRoleId(roleid);
        role.setDel(1);
        boolean b = roleService.updateById(role);
        System.out.println("是否删除角色成功：  " + b);
        if (b) {
            result = new Result(0, "删除成功！");
        } else {
            result = new Result(500, "删除失败");
        }
        return result;
    }


}
