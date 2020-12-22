package com.sgu.domain;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@TableName("users")
public class Users {

  @TableId(value = "userid",type = IdType.AUTO)
  private Integer userid;

  private String no;
  private String password;

  @TableField(value = "realname")
  private String realname;
  private String email;
  private Integer status; // 激活状态
  private Integer del;  // 是否删除
  private String modifytime;
  private String createTime;


  @TableField(exist = false)
  private Role role;


}
