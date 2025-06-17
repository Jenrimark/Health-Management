package cn.kmbeast;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("cn.kmbeast.mapper")
public class PersonalHealthApplication {
    public static void main(String[] args) {
        SpringApplication.run(PersonalHealthApplication.class, args);
    }
}