package com.sgu.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.sgu.domain.RoleResources;

/**
 * @author huang
 * @date 2020/12/20 18:29
 */
public interface RoleResourcesMapper extends BaseMapper<RoleResources> {
    int deleteMore(Integer roleId);

}
