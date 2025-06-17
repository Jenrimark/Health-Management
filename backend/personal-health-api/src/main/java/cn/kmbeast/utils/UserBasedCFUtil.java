package cn.kmbeast.utils;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 基于用户的协同过滤推荐工具类
 */
public class UserBasedCFUtil {

    // 用户-物品评分矩阵
    private final Map<Integer, Map<Integer, Double>> userItemMatrix;

    public UserBasedCFUtil(Map<Integer, Map<Integer, Double>> userItemMatrix) {
        this.userItemMatrix = userItemMatrix;
    }

    /**
     * 计算两个用户的余弦相似度
     *
     * @param user1 用户1的评分向量
     * @param user2 用户2的评分向量
     * @return 余弦相似度
     */
    public double cosineSimilarity(Map<Integer, Double> user1, Map<Integer, Double> user2) {
        double dotProduct = 0.0;
        double norm1 = 0.0, norm2 = 0.0;

        // 计算点积和范数
        for (Integer item : user1.keySet()) {
            if (user2.containsKey(item)) {
                dotProduct += user1.get(item) * user2.get(item);
            }
            norm1 += Math.pow(user1.get(item), 2);
        }
        for (Integer item : user2.keySet()) {
            norm2 += Math.pow(user2.get(item), 2);
        }
        // 计算余弦相似度
        return dotProduct / (Math.sqrt(norm1) * Math.sqrt(norm2)); //点积除以两个范数的乘积(余弦值)
    }

    /**
     * 为目标用户生成推荐物品列表
     *
     * @param targetUserId 目标用户ID
     * @param topN         推荐物品数量
     * @return 推荐物品ID列表
     */
    public List<Integer> recommendItems(int targetUserId, int topN) {
        Map<Integer, Double> targetUser = userItemMatrix.get(targetUserId);
        if (targetUser == null) {
            return new ArrayList<>();
        }
        // 优先队列用于存储相似用户
        PriorityQueue<SimilarUser> heap = new PriorityQueue<>();
        // 计算所有用户的相似度
        for (Integer otherUserId : userItemMatrix.keySet()) {
            if (otherUserId == targetUserId) continue; // 跳过目标用户
            double sim = cosineSimilarity(targetUser, userItemMatrix.get(otherUserId));
            heap.add(new SimilarUser(otherUserId, sim));
        }
        heap.forEach(h -> {
            System.out.println("用户ID：" + h.userId + "<=>相似度：" + h.similarity);
        });
        // 聚合相似用户评分
        Map<Integer, Double> itemScores = new HashMap<>();
        for (int i = 0; i < 20 && !heap.isEmpty(); i++) {  // 取Top20相似用户
            SimilarUser simUser = heap.poll();
            for (Map.Entry<Integer, Double> entry : userItemMatrix.get(simUser.userId).entrySet()) {
                if (targetUser.containsKey(entry.getKey())) {
                    itemScores.merge(entry.getKey(), entry.getValue() * simUser.similarity, Double::sum);
                }
            }
        } //累加相似用户对该物品的评分×相似度
        System.out.println("聚合结果：" + itemScores); //对于某物体，用户结果全部加起来
        // 返回得分最高的物品
        return itemScores.entrySet().stream()
                .sorted(Map.Entry.comparingByValue(Comparator.reverseOrder()))
                .limit(topN)
                .map(Map.Entry::getKey)
                .collect(Collectors.toList());
    }

    /**
     * 相似用户类
     */
    private static class SimilarUser implements Comparable<SimilarUser> {
        int userId;
        double similarity;

        public SimilarUser(int userId, double similarity) {
            this.userId = userId;
            this.similarity = similarity;
        }

        @Override
        public int compareTo(SimilarUser other) {
            return Double.compare(other.similarity, this.similarity); // 按相似度降序排序
        }
    }

    /**
     * 评分内部类
     */
    @Setter
    @Getter
    @AllArgsConstructor
    public static class Score {
        /**
         * 评分者用户ID
         */
        private Integer userId;
        /**
         * 物品ID
         */
        private Integer itemId;
        /**
         * 评分分数
         */
        private Integer score;
    }

    /**
     * 构建用户-物品评分矩阵
     *
     * @param itemIds  物品ID列表
     * @param scoreVOS 评分数据集合
     * @return Map<Integer, Map < Integer, Double>>
     */
    public static Map<Integer, Map<Integer, Double>> buildUserItemMatrix(List<Integer> itemIds, List<Score> scoreVOS) {
        // 获取所有物品ID
        Set<Integer> allNewsIds = new HashSet<>(itemIds);
        // 获取所有评分者用户ID
        Set<Integer> allUserIds = new HashSet<>();
        for (Score score : scoreVOS) {
            allUserIds.add(score.getUserId());
        }
        // 构建用户-物品评分矩阵
        Map<Integer, Map<Integer, Double>> userItemMatrix = new HashMap<>();
        // 初始化每个用户的评分映射，默认值为0
        for (Integer userId : allUserIds) {
            Map<Integer, Double> itemScores = new HashMap<>();
            for (Integer newsId : allNewsIds) {
                itemScores.put(newsId, 0.0);
            }
            userItemMatrix.put(userId, itemScores);
        }
        // 填充已有评分
        scoreVOS.forEach(scoreVO -> {
            Integer userId = scoreVO.getUserId();
            Integer itemId = scoreVO.getItemId();
            Double score = Double.valueOf(scoreVO.getScore());
            userItemMatrix.computeIfAbsent(userId, k -> new HashMap<>()).put(itemId, score);
        });
        return userItemMatrix;
    }
    // 打印评分矩阵，方便调试
    public static void printUserItemMatrix(Map<Integer, Map<Integer, Double>> userItemMatrix) {
        System.out.println("当前用户评分矩阵：");
        // 获取所有新闻ID并排序
        Set<Integer> allNewsIds = new TreeSet<>();
        for (Map<Integer, Double> itemScores : userItemMatrix.values()) {
            allNewsIds.addAll(itemScores.keySet());
        }

        // 打印表头
        System.out.print("用户ID\t");
        for (Integer newsId : allNewsIds) {
            System.out.print("物品" + newsId + "\t");
        }
        System.out.println();

        // 打印每一行数据
        for (Map.Entry<Integer, Map<Integer, Double>> entry : userItemMatrix.entrySet()) {
            System.out.print(entry.getKey() + "\t");
            for (Integer newsId : allNewsIds) {
                Double score = entry.getValue().getOrDefault(newsId, 0.0);
                System.out.print(score + "\t");
            }
            System.out.println();
        }
    }

}