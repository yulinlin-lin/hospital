package com.sgu.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.sgu.domain.Register;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author huang
 * @date 2020/12/9 21:19
 */
public interface RegisterMapper extends BaseMapper<Register> {

    List<Register> queryRegisterByPage(
                                       @Param("bingLiId")  String bingLiId,
                                       @Param("doctorName")  String doctorName,
                                       @Param("depName")  String depName,
                                       @Param("startCreateTime")  String startCreateTime,
                                       @Param("endCreateTime")  String endCreateTime
                                       );


    Register queryRegisterByBlindId(String id);

    boolean updateMoreBounceByList(List<String> list);

}
