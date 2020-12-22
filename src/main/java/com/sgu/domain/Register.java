package com.sgu.domain;


import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@TableName("register")
public class Register {

  private String bingLiId;
  private String name;
  private String identifierType;
  private String identifier;
  private String insuranceint;
  private String phone;
  private String expenseFlag;
  private Integer gender;
  private Integer age;
  private String profession;
  private String czflag;
  private Integer doctorId;
  private String modifyTime;
  private String createTime;
  private Integer status;
  private String remark;
  private double guahaofei;

  private Integer del;


  @TableField(exist = false)
  private Doctor d;

  @TableField(exist = false)
  private Dep dep;


}
