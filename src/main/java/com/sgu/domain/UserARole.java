package com.sgu.domain;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.aspectj.weaver.ast.Var;

/**
 * @author huang
 * @date 2020/12/18 20:20
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@TableName("user_role")
public class UserARole {

    @TableId(value = "urid",type = IdType.AUTO)
    private Integer urid;
    private Integer userId;
    private Integer roleId;

}
