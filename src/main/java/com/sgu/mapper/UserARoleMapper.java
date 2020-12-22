package com.sgu.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.sgu.domain.UserARole;
import org.apache.ibatis.annotations.Param;

/**
 * @author huang
 * @date 2020/12/18 20:24
 */
public interface UserARoleMapper extends BaseMapper<UserARole> {
    boolean updateUserRoleId(@Param("userid") Integer userid,
                             @Param("rid") Integer rid,
                             @Param("oldroleid") Integer oldroleid);

}
