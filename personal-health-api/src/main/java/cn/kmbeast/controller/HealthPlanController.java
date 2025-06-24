package cn.kmbeast.controller;

import cn.kmbeast.aop.Pager;
import cn.kmbeast.aop.Protector;
import cn.kmbeast.context.LocalThreadHolder;
import cn.kmbeast.pojo.api.Result;
import cn.kmbeast.pojo.dto.query.extend.HealthPlanQueryDto;
import cn.kmbeast.pojo.entity.Cookbook;
import cn.kmbeast.pojo.entity.HealthPlan;
import cn.kmbeast.pojo.vo.HealthPlanVO;
import cn.kmbeast.service.HealthPlanService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 食谱的控制器
 */
@RestController
@RequestMapping("/health-plans")
public class HealthPlanController {

    @Resource
    private HealthPlanService healthplanService;

    /**
     * 食谱新增
     *
     * @param healthplan 新增实体
     * @return Result<String> 响应结果
     */
    @PostMapping(value = "/save")
    @ResponseBody
    public Result<String> save(@RequestBody HealthPlan healthplan) {
        return healthplanService.save(healthplan);
    }


    /**
     * 食谱删除
     *
     * @param ids 目标ID列表
     * @return Result<String> 响应结果
     */
    @PostMapping(value = "/batchDelete")
    @ResponseBody
    public Result<String> batchDelete(@RequestBody List<Integer> ids) {
        return healthplanService.batchDelete(ids);
    }
    /**
     * 食谱修改
     *
     * @param healthplan 新增实体
     * @return Result<String> 响应结果
     */
    @PutMapping(value = "/update")
    @ResponseBody
    public Result<String> update(@RequestBody HealthPlan healthplan) {
        return healthplanService.update(healthplan);
    }

    /**
     * 查询用户的食谱
     *
     * @param healthplanQueryDto 查询参数
     * @return Result<List < Category>> 响应结果
     */
    @Pager
    @PostMapping(value = "/queryUser")
    @ResponseBody
    public Result<List<HealthPlanVO>> queryUser(@RequestBody HealthPlanQueryDto healthplanQueryDto) {
        healthplanQueryDto.setUserId(LocalThreadHolder.getUserId());
        return healthplanService.queryUser(healthplanQueryDto);
    }
    /**
     * 获取用户最近一次健康计划
     * @return Result<HealthPlanVO> 响应结果
     */
    @GetMapping("/latest")
    @ResponseBody
    public Result<HealthPlanVO> getLatestPlan() {
        return healthplanService.getLatestPlan();
    }


}

