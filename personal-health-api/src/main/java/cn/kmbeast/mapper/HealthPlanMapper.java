package cn.kmbeast.mapper;

import cn.kmbeast.pojo.dto.query.extend.HealthPlanQueryDto;
import cn.kmbeast.pojo.entity.HealthPlan;
import cn.kmbeast.pojo.vo.HealthPlanVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 食谱的持久化接口
 */
@Mapper
public interface HealthPlanMapper {

    void save(HealthPlan healthplan);

    void update(HealthPlan healthplan);

    void batchDelete(@Param(value = "ids") List<Integer> ids);

    List<HealthPlanVO> queryUser(HealthPlanQueryDto healthplanQueryDto);

    Integer queryCount(HealthPlanQueryDto healthplanQueryDto);
    // 添加获取用户最近一次健康计划的方法
    HealthPlanVO getLatestPlan(@Param("userId") Integer userId);

}
