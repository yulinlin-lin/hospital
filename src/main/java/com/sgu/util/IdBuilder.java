package com.sgu.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author huang
 * @date 2020/12/14 15:23
 */
public class IdBuilder {

    public static String getRegistrationID(){
        Date date = new Date();
        SimpleDateFormat sdformat = new SimpleDateFormat("HHmmssSSS");
        String id = sdformat.format(date);
//        Integer integer = Integer.parseInt(id);
        return id;
    }

}
