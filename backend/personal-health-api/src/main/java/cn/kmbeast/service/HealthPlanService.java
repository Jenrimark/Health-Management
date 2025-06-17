package cn.kmbeast.service;

import cn.kmbeast.pojo.api.Result;
import cn.kmbeast.pojo.dto.query.extend.HealthPlanQueryDto;
import cn.kmbeast.pojo.entity.Cookbook;
import cn.kmbeast.pojo.entity.HealthPlan;
import cn.kmbeast.pojo.vo.HealthPlanVO;

import java.util.List;

/**
 * 食谱业务逻辑接口
 */
public interface HealthPlanService {

    Result<String> save(HealthPlan healthplan);

    Result<String> batchDelete(List<Integer> ids);

    Result<String> update(HealthPlan healthplan);

    Result<List<HealthPlanVO>> queryUser(HealthPlanQueryDto healthplanQueryDto);
    // 添加获取最近一次健康计划的方法
    Result<HealthPlanVO> getLatestPlan();


}
