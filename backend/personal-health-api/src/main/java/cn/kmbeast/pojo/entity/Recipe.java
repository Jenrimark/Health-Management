
package cn.kmbeast.pojo.entity;

import lombok.Data;

@Data
public class Recipe {
    private Integer id;
    private String name;
    private String description;
    private String image;
    private Integer mealType; // 1:早餐 2:午餐 3:晚餐
    private Integer regionId;
    private Integer seasonId;
}