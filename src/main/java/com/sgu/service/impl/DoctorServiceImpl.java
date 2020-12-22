package com.sgu.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.sgu.domain.Doctor;
import com.sgu.mapper.DoctorMapper;
import com.sgu.service.DoctorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author huang
 * @date 2020/12/15 15:02
 */
@Service
public class DoctorServiceImpl extends ServiceImpl<DoctorMapper, Doctor> implements DoctorService {

    @Autowired
    private DoctorMapper doctorMapper;

    @Override
    public List<Doctor> queryDoctorsByCondition(Integer doctorId, String name, String depName) {
        return doctorMapper.queryDoctorsByCondition(doctorId,name,depName);
    }

    @Override
    public Doctor queryDoctorsById(Integer doctorId) {
        return doctorMapper.queryDoctorsById(doctorId);
    }
}
