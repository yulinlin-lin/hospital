package com.sgu.service;

import com.baomidou.mybatisplus.service.IService;
import com.sgu.domain.Doctor;

import java.util.List;

/**
 * @author huang
 * @date 2020/12/15 15:01
 */
public interface DoctorService extends IService<Doctor> {
    List<Doctor> queryDoctorsByCondition(Integer doctorId, String name, String depName);

    Doctor queryDoctorsById(Integer doctorId);

}
