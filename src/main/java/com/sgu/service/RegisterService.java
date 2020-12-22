package com.sgu.service;

import com.baomidou.mybatisplus.service.IService;
import com.sgu.domain.Register;

import java.util.List;

/**
 * @author huang
 * @date 2020/12/9 21:21
 */
public interface RegisterService extends IService<Register> {
    List<Register> queryRegisterByPage(
                                       String bingLiId,
                                       String doctorName,
                                       String depName,
                                       String startCreateTime,
                                       String endCreateTime);

    Register queryRegisterByBlindId(String id);

    boolean updateMoreBounceByList(List<String> list);

}

