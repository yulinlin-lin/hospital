package com.sgu.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.sgu.domain.Doctor;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author huang
 * @date 2020/12/15 14:54
 */
public interface DoctorMapper extends BaseMapper<Doctor> {
    List<Doctor> queryDoctorsByCondition(@Param("doctorId") Integer doctorId,
                                         @Param("name") String name,
                                         @Param("depName") String depName);

    Doctor queryDoctorsById(Integer doctorId);

}
