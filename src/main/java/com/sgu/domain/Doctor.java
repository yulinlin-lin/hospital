package com.sgu.domain;


import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@TableName("doctor")
public class Doctor {

  @TableId(value = "doctorId",type = IdType.AUTO)//指定自增策略
  private Integer doctorId;
  private String name;
  private Integer identifierType;
  private String identifier;
  private String phone;
  private String telephone;
  private Integer gender;
  private Integer age;
  private String birthDate;
  private String email;
  private Integer depid;
  private Integer degree;
  private String remark;
  private String createTime;
  private Integer del;


  @TableField(exist = false)
  private Dep dep;



}
