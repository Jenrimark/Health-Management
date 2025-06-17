package cn.kmbeast.pojo.vo;

import cn.kmbeast.pojo.entity.HealthPlan;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.Date;

/**
 * 食谱VO类
 */
@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
public class HealthPlanVO extends HealthPlan {
    private Integer id;
    private Integer userId;
    private Date planDate;
    private Integer targetCalories;
    private Integer exerciseMinutes;
    private Double sleepHours;
    private Integer waterCups;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")

    private LocalDateTime updateTime;


}
