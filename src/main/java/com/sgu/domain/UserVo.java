package com.sgu.domain;

import lombok.*;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * @author huang
 * @date 2020/12/21 14:52
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class UserVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer userid;
    private String no;
    private String realname;

    private List<Map<String, Object>> list;

}
