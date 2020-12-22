package com.sgu.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.sgu.domain.Resources;
import com.sgu.mapper.ResourcesMapper;
import com.sgu.service.ResourcesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author huang
 * @date 2020/12/19 23:58
 */
@Service
public class ResourcesServiceImpl extends ServiceImpl<ResourcesMapper, Resources> implements ResourcesService {

    @Autowired
    private ResourcesMapper resourcesMapper;

    @Override
    public List<Resources> queryResourcesByConditions(String resname) {
        return resourcesMapper.queryResourcesByConditions(resname);
    }
}
