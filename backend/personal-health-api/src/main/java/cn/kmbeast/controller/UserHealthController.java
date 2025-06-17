package cn.kmbeast.controller;

import cn.kmbeast.aop.Pager;
import cn.kmbeast.context.LocalThreadHolder;
import cn.kmbeast.pojo.api.*;
import cn.kmbeast.pojo.dto.query.base.QueryDto;
import cn.kmbeast.pojo.dto.query.extend.UserHealthQueryDto;
import cn.kmbeast.pojo.entity.UserHealth;
import cn.kmbeast.pojo.vo.ChartVO;
import cn.kmbeast.pojo.vo.UserHealthVO;
import cn.kmbeast.service.UserHealthService;
import cn.kmbeast.service.HealthModelConfigService;
import cn.kmbeast.utils.DateUtil;
import org.springframework.web.bind.annotation.*;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 用户健康记录的 Controller
 */
@RestController
@RequestMapping(value = "/user-health")
public class UserHealthController {

    @Resource
    private UserHealthService userHealthService;
    @Resource
    private HealthModelConfigService healthModelConfigService;
    @Resource
    private AIController aiController;


    /**
     * 用户健康记录新增
     *
     * @param userHealths 新增数据
     * @return Result<Void> 通用响应体
     */
    @PostMapping(value = "/save")
    public Result<Void> save(@RequestBody List<UserHealth> userHealths) {
        return userHealthService.save(userHealths);
    }

    /**
     * 用户健康记录删除
     *
     * @param ids 要删除的用户健康记录ID列表
     * @return Result<Void> 通用响应体
     */
    @PostMapping(value = "/batchDelete")
    public Result<Void> batchDelete(@RequestBody List<Long> ids) {
        return userHealthService.batchDelete(ids);
    }

    /**
     * 用户健康记录修改
     *
     * @param userHealth 参数
     * @return Result<Void> 响应
     */
    @PutMapping(value = "/update")
    public Result<Void> update(@RequestBody UserHealth userHealth) {
        return userHealthService.update(userHealth);
    }

    /**
     * 用户健康记录查询
     *
     * @param userHealthQueryDto 查询参数
     * @return Result<List < UserHealthVO>> 通用响应
     */
    @Pager
    @PostMapping(value = "/query")
    public Result<List<UserHealthVO>> query(@RequestBody UserHealthQueryDto userHealthQueryDto) {
        return userHealthService.query(userHealthQueryDto);
    }

    /**
     * 用户健康记录查询
     *
     * @param userHealthQueryDto 查询参数
     * @return Result<List < UserHealthVO>> 通用响应
     */
    @Pager
    @PostMapping(value = "/queryUser")
    public Result<List<UserHealthVO>> queryUser(@RequestBody UserHealthQueryDto userHealthQueryDto) {
        userHealthQueryDto.setUserId(LocalThreadHolder.getUserId());
        return userHealthService.query(userHealthQueryDto);
    }

    /**
     * 用户健康记录查询
     *
     * @param id  健康模型ID
     * @param day 往前查多少天
     * @return Result<List < UserHealthVO>> 通用响应
     */
    @GetMapping(value = "/timeQuery/{id}/{day}")
    public Result<List<UserHealthVO>> timeQuery(@PathVariable Integer id,
                                                @PathVariable Integer day) {
        // 有了时间范围，也有了健康模型ID，还需要什么？
        Integer userId = LocalThreadHolder.getUserId();
        QueryDto queryDto = DateUtil.startAndEndTime(day);
        UserHealthQueryDto userHealthQueryDto = new UserHealthQueryDto();
        userHealthQueryDto.setHealthModelConfigId(id);
        userHealthQueryDto.setUserId(userId);
        userHealthQueryDto.setStartTime(queryDto.getStartTime());
        userHealthQueryDto.setEndTime(queryDto.getEndTime());
        return userHealthService.query(userHealthQueryDto);
    }

    /**
     * 统计模型存量数据
     *
     * @return Result<List < ChartVO>> 响应结果
     */
    @GetMapping(value = "/daysQuery/{day}")
    @ResponseBody
    public Result<List<ChartVO>> query(@PathVariable Integer day) {
        return userHealthService.daysQuery(day);
    }

    @GetMapping("/report/{type}")
    public ApiResult<Map<String, Object>> generateHealthReport(@PathVariable String type) {
        try {
            Integer userId = LocalThreadHolder.getUserId();

            // 1. 获取时间范围
            QueryDto timeRange = getTimeRange(type);
            if (timeRange == null) {
                return createErrorResult("报告类型参数错误，请使用week或month");
            }

            // 2. 获取用户所有健康记录数据
            UserHealthQueryDto queryDto = new UserHealthQueryDto();
            queryDto.setUserId(userId);
            queryDto.setStartTime(timeRange.getStartTime());
            queryDto.setEndTime(timeRange.getEndTime());

            Result<List<UserHealthVO>> recordsResult = userHealthService.query(queryDto);
            List<UserHealthVO> allRecords = safelyExtractData(recordsResult);

            // 3. 按健康模型分组
            Map<Integer, List<UserHealthVO>> recordsByModel = allRecords.stream()
                    .collect(Collectors.groupingBy(UserHealthVO::getHealthModelConfigId));

            // 4. 生成报告数据
            Map<String, Object> reportData = new HashMap<>();
            List<Map<String, Object>> healthMetrics = new ArrayList<>();
            List<String> warnings = new ArrayList<>();

            recordsByModel.forEach((modelId, records) -> {
                if (!records.isEmpty()) {
                    UserHealthVO sampleRecord = records.get(0);
                    Map<String, Object> metric = createHealthMetric(sampleRecord, records);
                    healthMetrics.add(metric);
                    checkForWarnings(warnings, metric);
                }
            });

            // 5. 设置报告基本信息
            reportData.put("healthMetrics", healthMetrics);
            reportData.put("timeRange", timeRange);
            reportData.put("reportType", type);
            reportData.put("warnings", warnings);

            Map<String, Object> aiRequest = new HashMap<>();
            aiRequest.put("type", type);
            aiRequest.put("metrics", healthMetrics);
            aiRequest.put("warnings", warnings);

            ResponseEntity<Map> aiResponse = aiController.getHealthReportAdvice(aiRequest);
//处理ai响应
            if (aiResponse.getStatusCode() == HttpStatus.OK && aiResponse.getBody() != null) {
                Map<String, Object> aiBody = aiResponse.getBody();
                // 深度提取AI建议内容
                if (aiBody.containsKey("choices")) {
                    List<Map<String, Object>> choices = (List<Map<String, Object>>) aiBody.get("choices");
                    if (!choices.isEmpty()) {
                        Map<String, Object> firstChoice = choices.get(0);
                        if (firstChoice.containsKey("message")) {
                            Map<String, Object> message = (Map<String, Object>) firstChoice.get("message");
                            reportData.put("aiAdvice", message.get("content"));
                        }
                    }
                }
            } else {
                reportData.put("aiAdvice", "AI服务返回异常响应");
            }

            return new ApiResult<>(ResultCode.REQUEST_SUCCESS.getCode(), "报告生成成功", reportData);
        } catch (Exception e) {
            return new ApiResult<>(ResultCode.REQUEST_ERROR.getCode(), "生成报告时发生错误: " + e.getMessage());
        }
    }

    // ============== 辅助方法 ==============

    private QueryDto getTimeRange(String type) {
        if ("week".equalsIgnoreCase(type)) {
            return DateUtil.startAndEndTime(7);
        } else if ("month".equalsIgnoreCase(type)) {
            return DateUtil.startAndEndTime(30);
        }
        return null;
    }

    private Map<String, Object> createHealthMetric(UserHealthVO sampleRecord, List<UserHealthVO> records) {
        Map<String, Object> metric = new HashMap<>();
        metric.put("modelName", sampleRecord.getName());
        metric.put("unit", sampleRecord.getUnit());
        metric.put("symbol", sampleRecord.getSymbol());
        metric.put("valueRange", sampleRecord.getValueRange());
        metric.put("records", records);

        double avg = records.stream()
                .mapToDouble(r -> parseDoubleValue(r.getValue()))
                .average().orElse(0);
        double max = records.stream()
                .mapToDouble(r -> parseDoubleValue(r.getValue()))
                .max().orElse(0);
        double min = records.stream()
                .mapToDouble(r -> parseDoubleValue(r.getValue()))
                .min().orElse(0);

        metric.put("average", avg);
        metric.put("max", max);
        metric.put("min", min);

        return metric;
    }

    private void checkForWarnings(List<String> warnings, Map<String, Object> metric) {
        try {
            String[] range = ((String) metric.get("valueRange")).split(",");
            double minRange = Double.parseDouble(range[0]);
            double maxRange = Double.parseDouble(range[1]);
            double max = (double) metric.get("max");
            double min = (double) metric.get("min");

            if (max > maxRange || min < minRange) {
                warnings.add(String.format("%s有异常值(最高%.1f%s，最低%.1f%s，正常范围:%s-%s%s)",
                        metric.get("modelName"), max, metric.get("unit"),
                        min, metric.get("unit"), range[0], range[1], metric.get("unit")));
            }
        } catch (Exception e) {
            // 忽略格式错误的值范围
        }
    }

    private void addAiAdviceToReport(Map<String, Object> reportData,
                                     String type,
                                     List<Map<String, Object>> healthMetrics,
                                     List<String> warnings) {
        Map<String, Object> aiRequest = new HashMap<>();
        aiRequest.put("type", type);
        aiRequest.put("metrics", healthMetrics);
        aiRequest.put("warnings", warnings);

        ResponseEntity<?> aiResponse = aiController.getHealthReportAdvice(aiRequest);

        if (aiResponse.getStatusCode() == HttpStatus.OK && aiResponse.getBody() != null) {
            reportData.put("aiReport", aiResponse.getBody());
        } else {
            reportData.put("aiReport", "AI报告生成失败");
        }
    }

    private <T> List<T> safelyExtractData(Result<List<T>> result) {
        if (result instanceof ApiResult) {
            return ((ApiResult<List<T>>) result).getData();
        } else if (result instanceof PageResult) {
            return ((PageResult<List<T>>) result).getData();
        }
        return new ArrayList<>();
    }

    private double parseDoubleValue(Object value) {
        if (value instanceof Number) {
            return ((Number) value).doubleValue();
        }
        try {
            return Double.parseDouble(value.toString());
        } catch (Exception e) {
            return 0.0;
        }
    }

    private ApiResult<Map<String, Object>> createSuccessResult(Map<String, Object> data) {
        ApiResult<Map<String, Object>> result = new ApiResult<>(ResultCode.REQUEST_SUCCESS.getCode());
        result.setData(data);
        return result;
    }

    private ApiResult<Map<String, Object>> createErrorResult(String message) {
        ApiResult<Map<String, Object>> result = new ApiResult<>(ResultCode.REQUEST_ERROR.getCode());
        result.setMsg(message);
        return result;
    }
}
