package com.sgu.domain;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@TableName("role")
public class Role {

  @TableId(value = "roleId",type = IdType.AUTO)
  private Integer roleId;

  private String roleNum;
  private String roleName;
  private Integer status;
  private Integer del;


  @TableField(exist = false)
  private List<RoleResources> resources;

}
