package cn.kmbeast.pojo.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 用户视图对象
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserVO {

    private Integer id;

    private String userAccount;

    private String userName;

    private String userAvatar;

    private String userEmail;

    private Integer userRole;

    private Boolean isLogin;

    private Boolean isWord;
    
    private Boolean gender;
    
    private Integer age;

    /**
     * 注册时间
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;

}
