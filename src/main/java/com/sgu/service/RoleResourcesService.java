package com.sgu.service;

import com.baomidou.mybatisplus.service.IService;
import com.sgu.domain.RoleResources;

/**
 * @author huang
 * @date 2020/12/20 18:30
 */
public interface RoleResourcesService extends IService<RoleResources> {
    int deleteMore(Integer roleId);

}
