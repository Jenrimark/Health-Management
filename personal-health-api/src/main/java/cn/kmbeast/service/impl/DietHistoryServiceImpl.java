package cn.kmbeast.service.impl;

import cn.kmbeast.context.LocalThreadHolder;
import cn.kmbeast.mapper.DietHistoryMapper;
import cn.kmbeast.pojo.api.ApiResult;
import cn.kmbeast.pojo.api.Result;
import cn.kmbeast.pojo.dto.query.base.QueryDto;
import cn.kmbeast.pojo.dto.query.extend.DietHistoryQueryDto;
import cn.kmbeast.pojo.dto.query.extend.DietQueryDto;
import cn.kmbeast.pojo.entity.DietHistory;
import cn.kmbeast.pojo.vo.DietHistoryVO;
import cn.kmbeast.pojo.vo.DietNutrimentVO;
import cn.kmbeast.service.DietHistoryService;
import cn.kmbeast.utils.DateUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * 用户饮食业务逻辑接口实现类
 */
@Service
public class DietHistoryServiceImpl implements DietHistoryService {

    @Resource
    private DietHistoryMapper dietHistoryMapper;

    /**
     * 新增
     *
     * @param dietHistories 实体
     * @return Result<String> 通用的响应类
     */
    @Override
    public Result<String> save(List<DietHistory> dietHistories) {
        LocalDateTime dateTime = LocalDateTime.now();
        Integer userId = LocalThreadHolder.getUserId();
        for (DietHistory dietHistory : dietHistories) {
            dietHistory.setUserId(userId);
            dietHistory.setCreateTime(dateTime);
        }
        dietHistoryMapper.save(dietHistories);
        return ApiResult.success();

    }

    /**
     * 修改
     *
     * @param dietHistory 实体
     * @return Result<String> 通用的响应类
     */
    @Override
    public Result<String> update(DietHistory dietHistory) {
        if (dietHistory == null) {
            return ApiResult.error("饮食记录不能为空");
        }
        if (dietHistory.getCookbookId() == null) {
            return ApiResult.error("食谱不能为空");
        }
        if (dietHistory.getValue() == null) {
            return ApiResult.error("食用量不能为空");
        }

        dietHistoryMapper.update(dietHistory);
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
        if (CollectionUtils.isEmpty(ids)) {
            return ApiResult.error("ID列表不能为空");
        }
        dietHistoryMapper.batchDelete(ids);
        return ApiResult.success();
    }

    @Override
    public Result<List<DietHistoryVO>> query(DietHistoryQueryDto dietHistoryQueryDto) {
        List<DietHistoryVO> categoryList = dietHistoryMapper.query(dietHistoryQueryDto);
        Integer totalCount = dietHistoryMapper.queryCount(dietHistoryQueryDto);
        return ApiResult.success(categoryList, totalCount);
    }

    @Override
    public Result<List<DietHistoryVO>> queryUser(DietHistoryQueryDto dietHistoryQueryDto) {
        dietHistoryQueryDto.setUserId(LocalThreadHolder.getUserId());
        List<DietHistoryVO> dietHistoryVOS = dietHistoryMapper.queryUser(dietHistoryQueryDto);
        Integer totalCount = dietHistoryMapper.queryCount(dietHistoryQueryDto);
        return ApiResult.success(dietHistoryVOS, totalCount);
    }

    @Override
    public Result<List<DietNutrimentVO>> queryDietNutrimentInfo(DietQueryDto dietQueryDto) {
        dietQueryDto.setUserId(LocalThreadHolder.getUserId());
        DietHistoryQueryDto dietHistoryQueryDto = createDietHistoryQueryDto(dietQueryDto);
        List<DietHistoryVO> historyVOS = dietHistoryMapper.query(dietHistoryQueryDto);
        List<DietNutrimentVO> dietNutrimentVOS = parseNutriment(historyVOS, dietQueryDto);
        Collections.reverse(dietNutrimentVOS);
        return ApiResult.success(dietNutrimentVOS);
    }

    private DietHistoryQueryDto createDietHistoryQueryDto(DietQueryDto dietQueryDto) {
        Integer day = dietQueryDto.getDay();
        QueryDto queryDto = DateUtil.startAndEndTime(day);
        LocalDateTime startTime = queryDto.getStartTime();
        LocalDateTime endTime = queryDto.getEndTime();
        DietHistoryQueryDto dietHistoryQueryDto = new DietHistoryQueryDto();
        dietHistoryQueryDto.setStartTime(startTime);
        dietHistoryQueryDto.setEndTime(endTime);
        BeanUtils.copyProperties(dietQueryDto, dietHistoryQueryDto);
        return dietHistoryQueryDto;
    }

    private List<DietNutrimentVO> parseNutriment(List<DietHistoryVO> historyVOS,
                                                 DietQueryDto dietQueryDto) {
        List<DietNutrimentVO> dietNutrimentVOS = new ArrayList<>();
        for (DietHistoryVO historyVO : historyVOS) {
            if (!StringUtils.hasText(historyVO.getNutrimentName())) {
                continue;
            }
            DietNutrimentVO dietNutrimentVO = createDietNutrimentVO(historyVO);
            dietNutrimentVOS.add(dietNutrimentVO);
        }
        selectedNutrimentList(dietNutrimentVOS, dietQueryDto);
        return diffSum(dietNutrimentVOS);
    }

    public List<DietNutrimentVO> diffSum(List<DietNutrimentVO> dietNutrimentVOS) {
        Map<DietNutrimentVO, Integer> intermediateMap = dietNutrimentVOS.stream()
                .collect(Collectors.toMap(
                        Function.identity(),
                        DietNutrimentVO::getValue,
                        Integer::sum
                ));
        return intermediateMap.entrySet().stream()
                .map(entry -> new DietNutrimentVO(entry.getKey().getNutrimentId(),
                        entry.getKey().getNutrimentName(), entry.getValue(), entry.getKey().getTime()))
                .collect(Collectors.toList());
    }

    private DietNutrimentVO createDietNutrimentVO(DietHistoryVO dietHistoryVO) {
        if (dietHistoryVO == null) {
            return null;
        }

        String g100Value = dietHistoryVO.getG100Value();
        String value = dietHistoryVO.getValue();

        double inputValue = 0.0;
        double g100 = 0.0;

        if (value != null && !value.isEmpty()) {
            try {
                inputValue = Double.parseDouble(value);
            } catch (NumberFormatException e) {
                System.err.println("无法将值 " + value + " 转换为 double 类型: " + e.getMessage());
            }
        }

        if (g100Value != null && !g100Value.isEmpty()) {
            try {
                g100 = Double.parseDouble(g100Value);
            } catch (NumberFormatException e) {
                System.err.println("无法将值 " + g100Value + " 转换为 double 类型: " + e.getMessage());
            }
        }

        double sumInput = (inputValue / 100) * g100;
        String recordTime = dietHistoryVO.getCreateTime() != null ?
                dietHistoryVO.getCreateTime().toString().substring(5, 10) : "未知时间";

        DietNutrimentVO dietNutrimentVO = new DietNutrimentVO();
        dietNutrimentVO.setNutrimentId(dietHistoryVO.getNutrimentId());
        dietNutrimentVO.setValue((int) sumInput);
        dietNutrimentVO.setNutrimentName(dietHistoryVO.getNutrimentName());
        dietNutrimentVO.setTime(recordTime);

        return dietNutrimentVO;
    }

    private void selectedNutrimentList(List<DietNutrimentVO> dietNutrimentVOS,
                                       DietQueryDto dietQueryDto) {
        if (dietQueryDto.getNutrimentId() != null) {
            List<DietNutrimentVO> nutrimentVOS = dietNutrimentVOS.stream()
                    .filter(dietNutrimentVO -> Objects.equals(
                            dietNutrimentVO.getNutrimentId(),
                            dietQueryDto.getNutrimentId()
                    ))
                    .collect(Collectors.toList());
            dietNutrimentVOS.clear();
            dietNutrimentVOS.addAll(nutrimentVOS);
        }
    }
}