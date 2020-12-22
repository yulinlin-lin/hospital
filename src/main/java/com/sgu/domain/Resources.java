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
@TableName("resources")
public class Resources {
  @TableId(value = "resId",type = IdType.AUTO)
  private Integer resId;

  @TableField(value = "resname")
  private String resname;

  @TableField(value = "resurl")
  private String resurl;

  @TableField(value = "resparentid")
  private Integer resparentid;

  @TableField(value = "status")
  private Integer status;

  @TableField(value = "del")
  private Integer del;


}
