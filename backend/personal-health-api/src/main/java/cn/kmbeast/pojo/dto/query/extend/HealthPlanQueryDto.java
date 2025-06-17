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
    private Integer targetCalories;
    private Integer exerciseMinutes;
    private Double sleepHours;
    private Integer waterCups;
    private Date createTime;
    private Date updateTime;
}

