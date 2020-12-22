package com.sgu.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sgu.domain.Doctor;
import com.sgu.domain.Drugs;
import com.sgu.service.DrugsService;
import com.sgu.util.ExcelUtil;
import com.sgu.util.IdBuilder;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.UUID;

/**
 * @author huang
 * @date 2020/12/18 11:24
 */
@Controller
@RequestMapping("/drugs")
public class DrugsController {


    @Autowired
    private DrugsService drugsService;


    @RequestMapping("/dbExportToExcel")
    public List<Drugs> dbExportToExcel(@RequestParam(value = "drugName", required = false) String drugName,
                                        @RequestParam(value = "drugType", required = false) Integer drugType,
                                        HttpServletResponse response) {
        List<Drugs> drugs = drugsService.queryDrugsByCondition(drugName, drugType);


        //        给定头信息
        String[] cells_names = {"药品编号","药品名称","药品类型","简单描述","状态","剩余量"};

//        给定二维数组的长度，里面存放的就是要存放内容；
        String[][] values = new String[drugs.size()][6];
        for (int i = 0; i < drugs.size(); i++) {

            Drugs d = drugs.get(i);
            values[i][0] = d.getDrugsId();
            values[i][1] = d.getDrugName();
            values[i][2] = d.getDrugType().toString();
            values[i][3] = d.getDescription();
            values[i][4] = d.getDrugflag().toString();
            values[i][5] = d.getInventory().toString();
        }

        Workbook wb = ExcelUtil.getWorkbook("药品信息", cells_names, values);
        try {
            String fileName = "药品信息"+System.currentTimeMillis()+".xlsx";
            this.setResponseHeader(response, fileName);
            OutputStream os = response.getOutputStream();
            wb.write(os);//响应给客户端
            os.flush();
            os.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return drugs;
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
                             @RequestParam(value = "drugName", required = false) String drugName,
                             @RequestParam(value = "drugType", required = false) Integer drugType,
                             Model m) {
        PageHelper.startPage(pageNum, pageSize);
        List<Drugs> drugs = drugsService.queryDrugsByCondition(drugName, drugType);

        PageInfo<Drugs> pg3 = new PageInfo<Drugs>(drugs);
        m.addAttribute("pg3", pg3);

        m.addAttribute("drName", drugName);
        m.addAttribute("drType", drugType);

        return "drug/index";
    }


    @RequestMapping("/addDrug")
    public String addDrug(MultipartFile file, Drugs drug, HttpSession session) throws IOException {
//        开始图片上传到项目中的代码逻辑

        String filename = file.getOriginalFilename();
// 防止文件名相同被覆盖
        filename = UUID.randomUUID().toString().replace("-", "");
//指定上传文件的真实路径
        String realPath = session.getServletContext().getRealPath("/imgs/drug");

        File f = new File(realPath);
        if (!f.exists()) {
            f.mkdirs();
        }
        file.transferTo(new File(f, filename));
        drug.setDrugsId(drug.getDrugsId() + IdBuilder.getRegistrationID());
        drug.setDrugUrl(filename);
        drug.setDel(0);

        boolean insert = drugsService.insert(drug);


        System.out.println("插入是否成功：" + insert);

        return "forward:/drugs/index/1/5";
    }


    @RequestMapping("/look/{drugsId}")
    public String look(@PathVariable("drugsId") String drugsId, Model m) {
        Drugs drug = drugsService.selectOne(new EntityWrapper<Drugs>().eq("drugsId", drugsId));
        m.addAttribute("drug", drug);
        return "drug/look";
    }



}
