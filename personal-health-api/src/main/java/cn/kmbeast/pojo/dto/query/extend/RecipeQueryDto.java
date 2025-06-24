package cn.kmbeast.pojo.dto.query.extend;

import cn.kmbeast.pojo.dto.query.base.QueryDto;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class RecipeQueryDto extends QueryDto {
    private Integer regionId;
    private Integer seasonId;
    private String name;
    private Integer mealType;
}