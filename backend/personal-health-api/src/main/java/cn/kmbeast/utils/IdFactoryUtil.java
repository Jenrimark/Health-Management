package cn.kmbeast.utils;

import java.util.Random;
import java.util.UUID;

public class IdFactoryUtil {
    private static final Random random = new Random();
    
    public static String getFileId() {
        return UUID.randomUUID().toString().substring(1, 8);
    }
    
    public static Integer getIntegerId() {
        // 生成一个10000-999999之间的随机数作为ID
        return 10000 + random.nextInt(990000);
    }
}
