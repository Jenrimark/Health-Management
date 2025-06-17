package cn.kmbeast.pojo.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 评论点赞实体
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class EvaluationsUpvote {
    /**
     * 主键
     */
    private Integer id;
    /**
     * 用户ID
     */
    private Integer userId;
    /**
     * 评论ID
     */
    private Integer evaluationsId;
}