package cn.kmbeast.controller;

import cn.kmbeast.aop.Pager;
import cn.kmbeast.pojo.api.Result;
import cn.kmbeast.pojo.dto.query.extend.RecipeQueryDto;
import cn.kmbeast.pojo.entity.Recipe;
import cn.kmbeast.pojo.entity.Region;
import cn.kmbeast.pojo.entity.Season;
import cn.kmbeast.pojo.vo.RecipeVO;
import cn.kmbeast.service.RecipeService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/recipes")
public class RecipeController {

    @Resource
    private RecipeService recipeService;

    // 获取所有地区（用于下拉框）
    @GetMapping("/regions")
    public Result<List<Region>> getAllRegions() {
        return recipeService.getAllRegions();
    }

    // 获取所有季节（用于下拉框）
    @GetMapping("/seasons")
    public Result<List<Season>> getAllSeasons() {
        return recipeService.getAllSeasons();
    }

    // 新增地区食谱
    @PostMapping
    public Result<String> addRecipe(@RequestBody Recipe recipe) {
        return recipeService.save(recipe);
    }

    // 修改地区食谱
    @PutMapping
    public Result<String> updateRecipe(@RequestBody Recipe recipe) {
        return recipeService.update(recipe);
    }

    // 删除地区食谱
    @DeleteMapping("/{ids}")
    public Result<String> deleteRecipes(@PathVariable List<Integer> ids) {
        return recipeService.batchDelete(ids);
    }

    // 分页查询地区食谱
    @Pager
    @PostMapping("/query")
    public Result<List<RecipeVO>> queryRecipes(@RequestBody RecipeQueryDto queryDto) {
        return recipeService.query(queryDto);
    }
}