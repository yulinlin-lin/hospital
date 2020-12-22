package com.sgu.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.sgu.domain.Drugs;
import com.sgu.mapper.DrugsMapper;
import com.sgu.service.DrugsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author huang
 * @date 2020/12/18 10:43
 */
@Service
public class DrugsServiceImpl extends ServiceImpl<DrugsMapper, Drugs> implements DrugsService {

    @Autowired
    private DrugsMapper drugsMapper;

    @Override
    public List<Drugs> queryDrugsByCondition(String drugName, Integer drugType) {
        return drugsMapper.queryDrugsByCondition(drugName,drugType);
    }
}
