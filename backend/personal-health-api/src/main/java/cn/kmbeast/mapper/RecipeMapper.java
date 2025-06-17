package cn.kmbeast.mapper;

import cn.kmbeast.pojo.dto.query.extend.CookbookQueryDto;
import cn.kmbeast.pojo.entity.Recipe;
import cn.kmbeast.pojo.entity.Region;
import cn.kmbeast.pojo.entity.Season;
import cn.kmbeast.pojo.dto.query.extend.RecipeQueryDto;
import cn.kmbeast.pojo.vo.RecipeVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface RecipeMapper {
    // 用户端方法
    List<Recipe> getRecommendations(RecipeQueryDto queryDto);
    List<Region> getAllRegions();
    List<Season> getAllSeasons();

    // 管理端方法
    int insert(Recipe recipe);
    int updateById(Recipe recipe);
    int deleteBatchIds(List<Integer> ids);
    List<RecipeVO> query(RecipeQueryDto recipeQueryDto);
    int queryCount(RecipeQueryDto recipeQueryDto);
}