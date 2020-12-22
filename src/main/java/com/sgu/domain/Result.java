package com.sgu.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * @author huang
 * @date 2020/12/9 9:17
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Result {
    private Integer code;
    private String msg;
}
