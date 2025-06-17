package cn.kmbeast.pojo.vo;

import lombok.Data;

@Data
public class RecipeVO {
    private Integer id;
    private String name;
    private String description;
    private String image;
    private Integer mealType;
    private Integer regionId;
    private Integer seasonId;
    private String regionName;
    private String seasonName;
}