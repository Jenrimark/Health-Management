package cn.kmbeast.service.impl;

import cn.kmbeast.mapper.RecipeMapper;
import cn.kmbeast.pojo.api.ApiResult;
import cn.kmbeast.pojo.api.Result;
import cn.kmbeast.pojo.dto.query.extend.RecipeQueryDto;
import cn.kmbeast.pojo.entity.Recipe;
import cn.kmbeast.pojo.entity.Region;
import cn.kmbeast.pojo.entity.Season;
import cn.kmbeast.pojo.vo.RecipeVO;
import cn.kmbeast.service.RecipeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class RecipeServiceImpl implements RecipeService {

    @Resource
    private RecipeMapper recipeMapper;


    @Override
    public Result<List<Region>> getAllRegions() {
        List<Region> regions = recipeMapper.getAllRegions();
        return ApiResult.success(regions);
    }

    @Override
    public Result<List<Season>> getAllSeasons() {
        List<Season> seasons = recipeMapper.getAllSeasons();
        return ApiResult.success(seasons);
    }

    // 管理端新增方法
    @Override
    public Result<String> save(Recipe recipe) {
        int result = recipeMapper.insert(recipe);
        return result > 0 ? ApiResult.success("添加成功") : ApiResult.error("添加失败");
    }

    @Override
    public Result<String> update(Recipe recipe) {
        int result = recipeMapper.updateById(recipe);
        return result > 0 ? ApiResult.success("更新成功") : ApiResult.error("更新失败");
    }

    @Override
    public Result<String> batchDelete(List<Integer> ids) {
        int result = recipeMapper.deleteBatchIds(ids);
        return result > 0 ? ApiResult.success("删除成功") : ApiResult.error("删除失败");
    }

    @Override
    public Result<List<RecipeVO>> query(RecipeQueryDto recipeQueryDto) {
        List<RecipeVO> recipes = recipeMapper.query(recipeQueryDto);
        Integer totalCount = recipeMapper.queryCount(recipeQueryDto);
        return ApiResult.success(recipes,totalCount);
    }
}