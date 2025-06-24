package cn.kmbeast.service.impl;

import cn.kmbeast.context.LocalThreadHolder;
import cn.kmbeast.mapper.HealthPlanMapper;
import cn.kmbeast.pojo.api.ApiResult;
import cn.kmbeast.pojo.api.Result;
import cn.kmbeast.pojo.dto.query.extend.HealthPlanQueryDto;
import cn.kmbeast.pojo.entity.Cookbook;
import cn.kmbeast.pojo.entity.HealthPlan;
import cn.kmbeast.pojo.vo.HealthPlanVO;
import cn.kmbeast.service.HealthPlanService;
import cn.kmbeast.utils.IdFactoryUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 食谱业务逻辑接口实现类
 */
@Service
public class HealthPlanServiceImpl implements HealthPlanService {

    @Resource
    private HealthPlanMapper healthplanMapper;

    /**
     * 新增
     *
     * @param healthplan 实体
     * @return Result<String> 通用的响应类
     */
    @Override
    public Result<String> save(HealthPlan healthplan) {

        healthplan.setUserId(LocalThreadHolder.getUserId());
        // 确保ID不为空
        if (healthplan.getId() == null) {
            healthplan.setId(IdFactoryUtil.getIntegerId());
        }
        healthplan.setCreateTime(LocalDateTime.now());
        healthplanMapper.save(healthplan);
        return ApiResult.success();
    }


    /**
     * 删除
     *
     * @param ids ID列表
     * @return Result<String> 通用的响应类
     */
    @Override
    public Result<String> batchDelete(List<Integer> ids) {
        healthplanMapper.batchDelete(ids);
        return ApiResult.success();
    }
    /**
     * 修改
     *
     * @param healthplan 实体
     * @return Result<String> 通用的响应类
     */
    @Override
    public Result<String> update(HealthPlan healthplan) {
        healthplanMapper.update(healthplan);
        return ApiResult.success();
    }
    /**
     * 查询
     *
     * @param healthplanQueryDto 查询参数实体
     * @return Result<List < CookbookVO>> 通用的响应类
     */
    @Override
    public Result<List<HealthPlanVO>> queryUser(HealthPlanQueryDto healthplanQueryDto) {
        // 数据
        List<HealthPlanVO> categoryList = healthplanMapper.queryUser(healthplanQueryDto);
        // 数据量
        Integer totalCount = healthplanMapper.queryCount(healthplanQueryDto);
        return ApiResult.success(categoryList, totalCount);
    }
    @Override
    public Result<HealthPlanVO> getLatestPlan() {
        Integer userId = LocalThreadHolder.getUserId();
        HealthPlanVO latestPlan = healthplanMapper.getLatestPlan(userId);
        return ApiResult.success(latestPlan);
    }


}
