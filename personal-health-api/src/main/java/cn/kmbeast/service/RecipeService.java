package cn.kmbeast.service;

import cn.kmbeast.pojo.api.Result;
import cn.kmbeast.pojo.dto.query.extend.RecipeQueryDto;
import cn.kmbeast.pojo.entity.Recipe;
import cn.kmbeast.pojo.entity.Region;
import cn.kmbeast.pojo.entity.Season;
import cn.kmbeast.pojo.vo.RecipeVO;

import java.util.List;

public interface RecipeService {
    Result<List<Region>> getAllRegions();
    Result<List<Season>> getAllSeasons();
    Result<String> save(Recipe recipe);
    Result<String> update(Recipe recipe);
    Result<String> batchDelete(List<Integer> ids);
    Result<List<RecipeVO>> query(RecipeQueryDto queryDto);
}