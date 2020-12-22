package com.sgu.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author huang
 * @date 2020/12/15 16:48
 */
public class DataUtil {


    public static String getDate_YYYYMMdd(){
        SimpleDateFormat sim = new SimpleDateFormat("YYYY-MM-dd");
        String format = sim.format(new Date());
        return format;
    }


}
