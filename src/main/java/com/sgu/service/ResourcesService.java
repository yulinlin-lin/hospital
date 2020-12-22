package com.sgu.service;

import com.baomidou.mybatisplus.service.IService;
import com.sgu.domain.Resources;

import java.util.List;

/**
 * @author huang
 * @date 2020/12/19 23:58
 */
public interface ResourcesService extends IService<Resources> {
    List<Resources> queryResourcesByConditions(String resname);

}
