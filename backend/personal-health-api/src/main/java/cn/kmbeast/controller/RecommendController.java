package cn.kmbeast.controller;

import cn.kmbeast.pojo.api.Result;
import cn.kmbeast.pojo.vo.GourmetVO;
import cn.kmbeast.service.RecommendService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 内容推荐的控制器
 */
@RestController
@RequestMapping("/recommend")
public class RecommendController {

    @Resource
    private RecommendService recommendService;

    /**
     * 查询推荐的美食做法数据
     *
     * @param item 需要的推荐的条数
     * @return Result<List < GourmetVO>> 响应结果
     */
    @GetMapping(value = "/{item}")
    @ResponseBody
    public Result<List<GourmetVO>> recommendGourmet(@PathVariable Integer item) {
        return recommendService.recommendGourmet(item);
    }

}

