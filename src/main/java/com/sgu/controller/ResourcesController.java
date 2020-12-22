package com.sgu.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sgu.domain.Resources;
import com.sgu.domain.Result;
import com.sgu.domain.Role;
import com.sgu.service.ResourcesService;
import com.sgu.util.ExcelUtil;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;

/**
 * @author huang
 * @date 2020/12/19 23:59
 */
@Controller
@RequestMapping("/resource")
public class ResourcesController {

    @Autowired
    private ResourcesService resourcesService;

    @ResponseBody
    @RequestMapping("/getAllResources")
    public List<Resources> getAllResources() {
        List<Resources> res = resourcesService.selectList(new EntityWrapper<Resources>().eq("del", 0));
        return res;
    }

    @RequestMapping("/dbExportToExcel")
    public  List<Resources> dbExportToExcel(@RequestParam(value = "resname", required = false) String resname,
                                       HttpServletResponse response) {
        List<Resources> resources = resourcesService.queryResourcesByConditions(resname);


        //        给定头信息
        String[] cells_names = {"资源id","资源名称","资源路径","资源是否已经被删除（1是  0否）","资源是否禁用状态（0否， 1是）"};

//        给定二维数组的长度，里面存放的就是要存放内容；
        String[][] values = new String[resources.size()][5];
        for (int i = 0; i < resources.size(); i++) {

            Resources r = resources.get(i);
            values[i][0] = r.getResId().toString();
            values[i][1] = r.getResname();
            values[i][2] = r.getResurl();
            values[i][3] = r.getDel().toString();
            values[i][4] = r.getStatus().toString();
        }

        Workbook wb = ExcelUtil.getWorkbook("资源列表信息", cells_names, values);
        try {
            String fileName = "资源列表信息"+System.currentTimeMillis()+".xlsx";
            this.setResponseHeader(response, fileName);
            OutputStream os = response.getOutputStream();
            wb.write(os);//响应给客户端
            os.flush();
            os.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resources;
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
    public String indexDrugs(@PathVariable("pageNum") Integer pageNum,
                             @PathVariable("pageSize") Integer pageSize,
                             @RequestParam(value = "resname", required = false) String resname,
                             Model m) {

        PageHelper.startPage(pageNum, pageSize);
        List<Resources> resources = resourcesService.queryResourcesByConditions(resname);

        PageInfo<Resources> pg6 = new PageInfo<Resources>(resources);
        m.addAttribute("pg6", pg6);
        m.addAttribute("resname", resname);
        return "resource/index";
    }


    @GetMapping("/edit")
    public String queryeditPage(Integer rid, Model m) {
        Resources resources = resourcesService.selectById(rid);

        m.addAttribute("resources",resources);
        return "resource/edit";
    }


    @PostMapping("/edit")
    public String editResource(Resources r, Model m) {
        boolean b = resourcesService.updateById(r);
        System.out.println("修改资源： "+b);
        return "forward:/resource/index/1/5";
    }



    @ResponseBody
    @RequestMapping("/deleteById")
    public Result deleteById(Integer resId) {
        System.out.println("删除id: " + resId);
        Result result = null;
        Resources r = new Resources();
        r.setResId(resId);
        r.setDel(1);
        boolean b = resourcesService.updateById(r);

        if (b) {
            result = new Result(0, "删除成功！");
        } else {
            result = new Result(500, "删除失败！");
        }
        return result;
    }

}
