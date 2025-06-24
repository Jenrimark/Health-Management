package cn.kmbeast.mapper;

import cn.kmbeast.pojo.dto.query.extend.GourmetQueryDto;
import cn.kmbeast.pojo.entity.Gourmet;
import cn.kmbeast.pojo.vo.GourmetVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 美食做法的持久化接口
 */
@Mapper
public interface GourmetMapper {

    void save(Gourmet gourmet);

    void update(Gourmet gourmet);

    void batchDelete(@Param(value = "ids") List<Integer> ids);

    List<GourmetVO> query(GourmetQueryDto gourmetQueryDto);

    List<GourmetVO> queryByView(GourmetQueryDto gourmetQueryDto);

    Integer queryCount(GourmetQueryDto gourmetQueryDto);

    List<GourmetVO> queryByIds(@Param(value = "ids") List<Integer> ids);

}
