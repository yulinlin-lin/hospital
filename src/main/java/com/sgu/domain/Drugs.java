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
@TableName("drugs")
public class Drugs {

  private String drugsId;

  @TableField(value = "drugURL")
  private String drugUrl;
  private Integer purchasingPrice;
  private Integer sellingPrice;
  private String drugName;
  private Integer drugType;
  private String description;
  private String productionDate;
  private String expirationDate;
  private Integer shelfLife;
  private String detail;
  private String manufacturer;
  private String directions;
  private Integer countpurchases;
  private Integer inventory;
  private Integer drugflag;
  private String remark;
  private Integer del;


}
