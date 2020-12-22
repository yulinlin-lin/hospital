package com.sgu.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.sgu.domain.Register;
import com.sgu.mapper.RegisterMapper;
import com.sgu.service.RegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author huang
 * @date 2020/12/9 21:21
 */
@Service
public class RegisterServiceImpl extends ServiceImpl<RegisterMapper, Register> implements RegisterService {

    @Autowired
    private RegisterMapper registerMapper;

    @Override
    public List<Register> queryRegisterByPage(String bingLiId, String doctorName, String depName, String startCreateTime, String endCreateTime) {
        return registerMapper.queryRegisterByPage(bingLiId,doctorName,depName,startCreateTime,endCreateTime);
    }

    @Override
    public Register queryRegisterByBlindId(String id) {
        return registerMapper.queryRegisterByBlindId(id);
    }

    @Override
    public boolean updateMoreBounceByList(List<String> list) {
        return registerMapper.updateMoreBounceByList(list);
    }
}
