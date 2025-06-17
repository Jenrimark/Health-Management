package cn.kmbeast.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.Duration;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/api/personal-heath/v1.0/ai")
public class AIController {

    @Value("${gemini.api.key}")
    private String apiKey;

    private final RestTemplate restTemplate;

    public AIController(RestTemplateBuilder restTemplateBuilder) {
        // 设置60秒连接超时和120秒读取超时
        this.restTemplate = restTemplateBuilder
                .setConnectTimeout(Duration.ofSeconds(60))
                .setReadTimeout(Duration.ofSeconds(120))
                .build();
    }

    @PostMapping("/aiDiagnosis")
    public ResponseEntity<?> getDiagnosis(@RequestBody Map<String, String> request) {
        String question = request.get("question");
        
        // 输入清洗 - 移除潜在的XSS和注入字符
        String sanitizedQuestion = question != null ? 
            question.replaceAll("[<>{}\\[\\]&;$%'\"\\\\()+]", "") : "";
            
        //请求头
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        
        //请求体
        Map<String, Object> body = new HashMap<>();
        
        // 构建Gemini API请求格式
        List<Map<String, Object>> contents = new ArrayList<>();
        Map<String, Object> content = new HashMap<>();
        
        // 添加用户问题，Gemini可能不支持system role，改为只发送用户问题
        List<Map<String, Object>> parts = new ArrayList<>();
        
        // 用户问题 - 使用清洗后的问题
        Map<String, Object> userPart = new HashMap<>();
        userPart.put("text", "你是一个专业的医疗健康顾问，请根据用户描述的症状提供专业的建议。但要提醒用户这只是一般性建议，严重症状需要及时就医。\n\n用户问题：" + sanitizedQuestion);
        parts.add(userPart);
        
        content.put("parts", parts);
        contents.add(content);
        
        body.put("contents", contents);
        
        //发送请求
        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);
        
        try {
            ResponseEntity<Map> response = restTemplate.exchange(
                    "https://api.zetatechs.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + apiKey,
                    HttpMethod.POST,
                    entity,
                    Map.class
            );

            if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
                // 处理Gemini的响应格式
                Map<String, Object> responseBody = response.getBody();
                
                // 尝试提取文本响应
                try {
                    List<Map<String, Object>> candidates = (List<Map<String, Object>>) responseBody.get("candidates");
                    if (candidates != null && !candidates.isEmpty()) {
                        Map<String, Object> firstCandidate = candidates.get(0);
                        Map<String, Object> candidateContent = (Map<String, Object>) firstCandidate.get("content");
                        List<Map<String, Object>> contentParts = (List<Map<String, Object>>) candidateContent.get("parts");
                        String text = (String) contentParts.get(0).get("text");
                        
                        // 创建与前端期望的格式一致的响应
                        Map<String, Object> formattedResponse = new HashMap<>();
                        Map<String, Object> choices = new HashMap<>();
                        Map<String, Object> message = new HashMap<>();
                        message.put("content", text);
                        choices.put("message", message);
                        formattedResponse.put("choices", Collections.singletonList(choices));
                        
                        return ResponseEntity.ok(formattedResponse);
                    } else {
                        // 直接返回原始响应，让前端适配
                        return ResponseEntity.ok(responseBody);
                    }
                } catch (Exception e) {
                    // 如果解析失败，返回原始响应
                    return ResponseEntity.ok(responseBody);
                }
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
            
            // 构建用户问题
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
            userPrompt.append("\n5. 就医建议（如有必要）");
            
            // 构建Gemini API请求格式，去掉系统角色
            Map<String, Object> body = new HashMap<>();
            List<Map<String, Object>> contents = new ArrayList<>();
            Map<String, Object> content = new HashMap<>();
            
            List<Map<String, Object>> parts = new ArrayList<>();
            
            // 合并系统指令和用户问题
            String combinedPrompt = "你是一位专业的健康数据分析师，负责根据用户的健康数据生成详细报告。"
                    + "请提供专业的饮食、运动和生活习惯建议。"
                    + "对于异常数据要明确指出风险并提供就医建议。"
                    + "报告要结构清晰，分为摘要、详细分析和建议三部分。"
                    + "使用专业但易懂的语言，避免医学术语。\n\n"
                    + userPrompt.toString();
            
            // 用户问题
            Map<String, Object> userPart = new HashMap<>();
            userPart.put("text", combinedPrompt);
            parts.add(userPart);
            
            content.put("parts", parts);
            contents.add(content);
            
            body.put("contents", contents);

            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);

            // 发送请求
            ResponseEntity<Map> response = restTemplate.exchange(
                    "https://api.zetatechs.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + apiKey,
                    HttpMethod.POST,
                    entity,
                    Map.class
            );

            if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
                // 处理Gemini的响应格式
                Map<String, Object> responseBody = response.getBody();
                
                // 尝试提取文本响应
                try {
                    List<Map<String, Object>> candidates = (List<Map<String, Object>>) responseBody.get("candidates");
                    if (candidates != null && !candidates.isEmpty()) {
                        Map<String, Object> firstCandidate = candidates.get(0);
                        Map<String, Object> candidateContent = (Map<String, Object>) firstCandidate.get("content");
                        List<Map<String, Object>> contentParts = (List<Map<String, Object>>) candidateContent.get("parts");
                        String text = (String) contentParts.get(0).get("text");
                        
                        // 创建与前端期望的格式一致的响应
                        Map<String, Object> formattedResponse = new HashMap<>();
                        Map<String, Object> choices = new HashMap<>();
                        Map<String, Object> message = new HashMap<>();
                        message.put("content", text);
                        choices.put("message", message);
                        formattedResponse.put("choices", Collections.singletonList(choices));
                        
                        return ResponseEntity.ok(formattedResponse);
                    } else {
                        // 直接返回原始响应，让前端适配
                        return ResponseEntity.ok(responseBody);
                    }
                } catch (Exception e) {
                    // 如果解析失败，返回原始响应
                    return ResponseEntity.ok(responseBody);
                }
            } else {
                throw new RuntimeException("AI服务返回异常响应");
            }
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", "AI服务调用失败: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }
    
    // 添加API速率限制 (防止洪水攻击)
    @Bean
    public FilterRegistrationBean<RateLimitFilter> rateLimitFilter() {
        FilterRegistrationBean<RateLimitFilter> reg = new FilterRegistrationBean<>();
        reg.setFilter(new RateLimitFilter(100, 1)); // 100请求/分钟
        reg.addUrlPatterns("/api/personal-heath/v1.0/ai/*");
        return reg;
    }
}

// 防火墙白名单注解 (Spring Security)
@ControllerAdvice
class SecurityConfig extends ResponseEntityExceptionHandler {
    
    @Override
    protected ResponseEntity<Object> handleHttpMessageNotReadable(
        HttpMessageNotReadableException ex, HttpHeaders headers, 
        HttpStatus status, WebRequest request) {
        
        // 防止恶意JSON攻击
        return ResponseEntity.badRequest().body(
            Collections.singletonMap("error", "非法请求参数")
        );
    }
}

// 实现速率限制过滤器
class RateLimitFilter extends OncePerRequestFilter {
    private final int maxRequests;
    private final int timeWindow;
    private final Map<String, List<Long>> requestLog = new ConcurrentHashMap<>();

    public RateLimitFilter(int maxRequests, int timeWindow) {
        this.maxRequests = maxRequests;
        this.timeWindow = timeWindow;
    }

    @Override
    protected void doFilterInternal(
            HttpServletRequest request, 
            HttpServletResponse response, 
            FilterChain filterChain) throws ServletException, IOException {
        
        String clientIp = request.getRemoteAddr();
        long now = System.currentTimeMillis();
        
        // 获取该IP的请求记录
        List<Long> requests = requestLog.computeIfAbsent(clientIp, k -> new ArrayList<>());
        
        // 移除超出时间窗口的请求记录
        requests.removeIf(timestamp -> timestamp < now - TimeUnit.MINUTES.toMillis(timeWindow));
        
        // 检查是否超出速率限制
        if (requests.size() >= maxRequests) {
            response.setStatus(429); // 429 Too Many Requests
            response.getWriter().write("{\"error\":\"请求过于频繁，请稍后再试\",\"code\":429}");
            return;
        }
        
        // 记录本次请求
        requests.add(now);
        
        // 继续执行过滤器链
        filterChain.doFilter(request, response);
    }
}