package com.sgu.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.sgu.domain.Drugs;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author huang
 * @date 2020/12/18 10:41
 */
public interface DrugsMapper extends BaseMapper<Drugs> {
    List<Drugs> queryDrugsByCondition(@Param("drugName") String drugName,
                                      @Param("drugType") Integer drugType);

}
