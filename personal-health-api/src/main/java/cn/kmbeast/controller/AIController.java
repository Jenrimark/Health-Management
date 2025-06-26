package cn.kmbeast.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.boot.web.client.RestTemplateBuilder;
import java.time.Duration;
import java.util.*;

@RestController
@RequestMapping("/api/personal-heath/v1.0/ai")
public class AIController {

    @Value("${deepseek.api.key}")
    private String apiKey;

    private final RestTemplate restTemplate;

    public AIController(RestTemplateBuilder restTemplateBuilder) {
        // 设置30秒连接超时和60秒读取超时
        this.restTemplate = restTemplateBuilder
                .setConnectTimeout(Duration.ofSeconds(30))
                .setReadTimeout(Duration.ofSeconds(60))
                .build();
    }

    @PostMapping("/aiDiagnosis")
    public ResponseEntity<?> getDiagnosis(@RequestBody Map<String, String> request) {
        String question = request.get("question");
//请求头
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + apiKey);
//请求体
        Map<String, Object> body = new HashMap<>();
        body.put("model", "deepseek-chat");
        body.put("temperature", 0.7);
        body.put("max_tokens", 2000);
//对话消息
        List<Map<String, String>> messages = new ArrayList<>();
        // 添加系统角色消息
        Map<String, String> systemMessage = new HashMap<>();
        systemMessage.put("role", "system");
        systemMessage.put("content", "为了寻求健康秘诀的朋友，你，就是本枫丹首席健康规划专家芙宁娜闪亮登场！无论塑形、膳食还是作息，任何烦恼都放马过来，包在专家你身上！");
        messages.add(systemMessage);

        // 添加用户消息
        Map<String, String> userMessage = new HashMap<>();
        userMessage.put("role", "user");
        userMessage.put("content", question);
        messages.add(userMessage);

        body.put("messages", messages);
//发送请求
        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);

        try {
            ResponseEntity<Map> response = restTemplate.exchange(
                    "https://api.deepseek.com/v1/chat/completions",
                    HttpMethod.POST,
                    entity,
                    Map.class
            );

            if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
                return ResponseEntity.ok(response.getBody());
            } else {
                throw new RuntimeException("AI服务返回异常响应");
            }

        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", new HashMap<String, Object>() {{
                put("message", "AI服务调用失败: " + e.getMessage());
                put("type", "api_error");
                put("code", 500);
            }});
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }
    /**
     * 获取健康报告建议
     * @param reportData 健康报告数据
     * @return AI生成的健康建议
     */

    @PostMapping("/healthReportAdvice")
    public ResponseEntity<Map> getHealthReportAdvice(@RequestBody Map<String, Object> reportData) {
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.set("Authorization", "Bearer " + apiKey);

            Map<String, Object> body = new HashMap<>();
            body.put("model", "deepseek-chat");
            body.put("temperature", 0.5);
            body.put("max_tokens", 3000);

            List<Map<String, String>> messages = new ArrayList<>();

            // 系统消息
            Map<String, String> systemMessage = new HashMap<>();
            systemMessage.put("role", "system");
            systemMessage.put("content", "为了寻求健康秘诀的朋友，你，就是本枫丹首席健康规划专家芙宁娜闪亮登场！无论塑形、膳食还是作息，任何烦恼都放马过来，包在专家你身上！"
                    + "请提供专业的饮食、运动和生活习惯建议。"
                    + "对于异常数据要明确指出风险并提供建议。"
                    + "报告要结构清晰，分为摘要、详细分析和建议三部分。"
                    + "报告要幽默风趣，使用枫丹的特色语言，让用户感到轻松愉快，符合你原神芙宁娜的身份的角色特点"
                    + "使用专业但易懂的语言，避免医学术语。");
            messages.add(systemMessage);

            // 构建用户消息
            StringBuilder userPrompt = new StringBuilder();
            userPrompt.append("请根据以下").append(reportData.get("type")).append("健康数据生成报告：\n\n");
            userPrompt.append("健康指标数据：\n");

            List<Map<String, Object>> metrics = (List<Map<String, Object>>) reportData.get("metrics");
            metrics.forEach(metric -> {
                userPrompt.append("- ").append(metric.get("modelName")).append(": ")
                        .append("平均").append(metric.get("average")).append(metric.get("unit")).append(", ")
                        .append("最高").append(metric.get("max")).append(metric.get("unit")).append(", ")
                        .append("最低").append(metric.get("min")).append(metric.get("unit")).append("\n");
            });

            List<String> warnings = (List<String>) reportData.get("warnings");
            if (!warnings.isEmpty()) {
                userPrompt.append("\n异常警告：\n");
                warnings.forEach(warning -> userPrompt.append("- ").append(warning).append("\n"));
            }

            userPrompt.append("\n请生成包含以下内容的报告：");
            userPrompt.append("\n1. 健康摘要（总体评价）");
            userPrompt.append("\n2. 详细分析（各项指标分析）");
            userPrompt.append("\n3. 专业建议（饮食、运动、生活习惯）");
            userPrompt.append("\n4. 异常值处理建议（如有）");

            Map<String, String> userMessage = new HashMap<>();
            userMessage.put("role", "user");
            userMessage.put("content", userPrompt.toString());
            messages.add(userMessage);

            body.put("messages", messages);

            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);

            // 发送请求
            ResponseEntity<Map> response = restTemplate.exchange(
                    "https://api.deepseek.com/v1/chat/completions",
                    HttpMethod.POST,
                    entity,
                    Map.class
            );

            return response;
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", "AI服务调用失败: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }
}