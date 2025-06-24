package cn.kmbeast.pojo.dto.query.extend;

import cn.kmbeast.pojo.dto.query.base.QueryDto;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;

@Data
@EqualsAndHashCode(callSuper = true)
public class  HealthPlanQueryDto extends QueryDto {
    private Integer id;
    private Integer userId;
    private Date planDate;
    private Integer steps;
    private Integer exerciseMinutes;
    private String exerciseType;
    private Integer caloriesBurned;
    private Date createTime;
    private Date updateTime;
}

