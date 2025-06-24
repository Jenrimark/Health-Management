package cn.kmbeast.service.impl;


import cn.kmbeast.context.LocalThreadHolder;
import cn.kmbeast.mapper.GourmetMapper;
import cn.kmbeast.mapper.InteractionMapper;
import cn.kmbeast.pojo.api.ApiResult;
import cn.kmbeast.pojo.api.Result;
import cn.kmbeast.pojo.dto.query.extend.GourmetQueryDto;
import cn.kmbeast.pojo.dto.query.extend.InteractionQueryDto;
import cn.kmbeast.pojo.dto.query.extend.RatingDto;
import cn.kmbeast.pojo.em.InteractionTypeEnum;
import cn.kmbeast.pojo.vo.GourmetVO;
import cn.kmbeast.pojo.vo.InteractionVO;
import cn.kmbeast.service.RecommendService;
import cn.kmbeast.utils.MahoutUtils;
import org.apache.mahout.cf.taste.recommender.RecommendedItem;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import cn.kmbeast.utils.UserBasedCFUtil;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 推荐业务逻辑实现
 */
@Service
public class RecommendServiceImpl implements RecommendService {

    @Resource
    private InteractionMapper interactionMapper;
    @Resource
    private GourmetMapper gourmetMapper;


    /**
     * 查询需要推荐给用户的帖子数据
     * * @param item 需要的条数
     *
     * @return Result<List < GourmetVO>>
     */
    @Override
    public Result<List<GourmetVO>> recommendGourmet(Integer item) {
        System.out.println("=================【协同过滤推荐开始】=================");

        List<GourmetVO> gourmetVOS = gourmetMapper.query(new GourmetQueryDto());
        List<Integer> gourmetIds = gourmetVOS.stream()
                .filter(GourmetVO::getIsAudit) // 检索已审核的
                .filter(GourmetVO::getIsPublish) // 检索已公开的
                .map(GourmetVO::getId)
                .collect(Collectors.toList());
// 用户对于物品的评分数据
        InteractionQueryDto interactionQueryDto = new InteractionQueryDto();
        interactionQueryDto.setType(InteractionTypeEnum.RATING.getType());
        List<InteractionVO> interactionVOS = interactionMapper.query(interactionQueryDto);
// 期望用到的评分数据集
        List<UserBasedCFUtil.Score> scoreList = interactionVOS.stream().map(interactionVO -> new UserBasedCFUtil.Score(
                interactionVO.getUserId(),
                interactionVO.getContentId(),
                interactionVO.getScore()
        )).collect(Collectors.toList());
// 构建用户对于物品评分的矩阵
        Map<Integer, Map<Integer, Double>> userItemMatrix = UserBasedCFUtil.buildUserItemMatrix(gourmetIds, scoreList);
        UserBasedCFUtil.printUserItemMatrix(userItemMatrix);
        UserBasedCFUtil userBasedCFUtil = new UserBasedCFUtil(userItemMatrix);
        List<Integer> recommendItems = userBasedCFUtil.recommendItems(LocalThreadHolder.getUserId(), item);
        System.out.println("计算出来的推荐列表：" + recommendItems);
        System.out.println("=================【协同过滤推荐结束】=================");
        if (!recommendItems.isEmpty()) {
            // 最终推荐
            List<GourmetVO> gourmetVOList = gourmetMapper.queryByIds(recommendItems);
            return ApiResult.success(gourmetVOList);
        }
// 实在是没有关联，只能默认推荐最热门的
        List<Integer> gourmetSearchIds = gourmetIds.subList(0, gourmetIds.size() > item ? item : gourmetIds.size());
        List<GourmetVO> gourmetVOList = gourmetMapper.queryByIds(gourmetSearchIds);
        return ApiResult.success(gourmetVOList);
    }
}
