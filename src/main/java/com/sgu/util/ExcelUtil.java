package com.sgu.util;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 *    excel导出功能工具类
 * @author huang
 * @date 2020/12/16 19:32
 */
public class ExcelUtil {


    /***
     *
     * @param sheetName   选项卡的名称
     * @param cells_names  列名  它是一个一维数组
     * @param values       每一个单元格中的数据信息；
     * @return
     */
    public static Workbook getWorkbook(String sheetName,String[] cells_names,String[][] values){

        //        创建工作book
        Workbook wb = new XSSFWorkbook();
        //        创建选项卡
        Sheet sheet = wb.createSheet(sheetName);

        //        创建第一行的信息  也就是表头信息
        Row firstRow = sheet.createRow(0);

        //        给表头写信息；
        for (int i = 0; i < cells_names.length; i++) {
        // 利用第一行创建第一个单元格
            Cell cell = firstRow.createCell(i);
            // 给第一个单元格里面设置值；
            cell.setCellValue(cells_names[i]);
        }

        //        声明一   行
        Row row = null;

        //        声明单元格
        Cell c = null;

        //创建内容  对传递过来的二维数组进行创建内容设置；
        for (int i = 0; i < values.length; i++) {
            /*创建一行  第一行已经创建了，所以不能再创建第一行了 */
            row = sheet.createRow(i+1);
            for (int j = 0; j < values[i].length; j++) {
                //将内容按顺序赋给对应的列对象
                row.createCell(j).setCellValue(values[i][j]);
            }
        }
        //返回
        return wb;
    }


}
