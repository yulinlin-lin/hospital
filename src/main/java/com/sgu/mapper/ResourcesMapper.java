package com.sgu.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.sgu.domain.Resources;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author huang
 * @date 2020/12/19 23:56
 */
public interface ResourcesMapper extends BaseMapper<Resources> {
    List<Resources> queryResourcesByConditions(@Param("resname") String resname);

}
