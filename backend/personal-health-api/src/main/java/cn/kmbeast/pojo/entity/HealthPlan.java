package cn.kmbeast.pojo.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Date;

@Data
public class HealthPlan {
    private Integer id;
    private Integer userId;
    private Date planDate;
    private Integer steps;
    private Integer exerciseMinutes;
    private String exerciseType;
    private Integer caloriesBurned;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")

    private LocalDateTime updateTime;
} 