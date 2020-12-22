package com.sgu.service;

import com.baomidou.mybatisplus.service.IService;
import com.sgu.domain.Drugs;

import java.util.List;

/**
 * @author huang
 * @date 2020/12/18 10:43
 */
public interface DrugsService extends IService<Drugs> {
    List<Drugs> queryDrugsByCondition(String drugName, Integer drugType);
}
