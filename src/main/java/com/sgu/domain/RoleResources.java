package com.sgu.domain;

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
@TableName("role_resources")
public class RoleResources {

  @TableId(value = "userid",type = IdType.AUTO)
  private Integer resMiddleTableId;


  private Integer roleId;
  private Integer resId;



}
