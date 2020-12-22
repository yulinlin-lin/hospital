package com.sgu.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.sgu.domain.RoleResources;
import com.sgu.mapper.RoleResourcesMapper;
import com.sgu.service.RoleResourcesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author huang
 * @date 2020/12/20 18:30
 */
@Service
public class RoleResourcesServiceImpl extends ServiceImpl<RoleResourcesMapper, RoleResources> implements RoleResourcesService {

    @Autowired
    private RoleResourcesMapper roleResourcesMapper;

    @Override
    public int deleteMore(Integer roleId) {
        return roleResourcesMapper.deleteMore(roleId);
    }
}
