[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/Jenrimark/Health-Management)

# 蝶启新生-健康管理系统


ER图片生成


erDiagram
    %% 核心用户实体
    USER {
        int id PK
        varchar user_account
        varchar user_name
        varchar user_pwd
        varchar user_avatar
        varchar user_email
        int user_role
        boolean is_login
        boolean is_word
        boolean gender
        int age
        datetime create_time
    }

    %% 健康管理相关实体
    HEALTH_MODEL_CONFIG {
        int id PK
        int user_id FK
        varchar name
        varchar detail
        varchar cover
        varchar unit
        varchar symbol
        boolean is_global
        varchar value_range
    }

    USER_HEALTH {
        int id PK
        int user_id FK
        int health_model_config_id FK
        varchar value
        datetime create_time
    }

    HEALTH_PLAN {
        int id PK
        bigint user_id FK
        date plan_date
        int steps
        int exercise_minutes
        varchar exercise_type
        int calories_burned
        datetime create_time
        datetime update_time
    }

    HEALTHY_REPORT {
        int id PK
        varchar user_account FK
        varchar file_name
        varchar file_path
        varchar file_type
        bigint file_size
        datetime upload_time
        varchar description
        date report_date
        boolean is_deleted
        datetime create_time
        datetime update_time
    }

    %% 食谱与营养相关实体
    CATEGORY {
        int id PK
        varchar name
    }

    COOKBOOK {
        int id PK
        int user_id FK
        varchar cover
        varchar title
        int category_id FK
        longtext content
        boolean is_publish
        datetime create_time
    }

    NUTRIMENT {
        int id PK
        int user_id FK
        varchar name
        varchar detail
        varchar unit
        boolean is_publish
        datetime create_time
    }

    COOKBOOK_NUTRIMENT {
        int id PK
        int cookbook_id FK
        int nutriment_id FK
        varchar value_per_100g
    }

    DIET_HISTORY {
        int id PK
        int user_id FK
        int cookbook_id FK
        varchar detail
        varchar value
        datetime create_time
    }

    GOURMET {
        int id PK
        int user_id FK
        int category_id FK
        varchar title
        longtext content
        varchar cover
        boolean is_audit
        boolean is_publish
        datetime create_time
    }

    %% 社交互动相关实体
    EVALUATIONS {
        int id PK
        int parent_id FK
        int commenter_id FK
        int replier_id FK
        varchar content_type
        int content_id
        varchar content
        longtext upvote_list
        datetime create_time
    }

    EVALUATIONS_UPVOTE {
        int id PK
        int user_id FK
        int evaluations_id FK
    }

    INTERACTION {
        int id PK
        int type
        varchar content_type
        int content_id
        int user_id FK
        int score
        datetime create_time
    }

    MESSAGE {
        int id PK
        varchar content
        int message_type
        int receiver_id FK
        int sender_id FK
        boolean is_read
        int content_id
        datetime create_time
    }

    %% 家庭关系相关实体
    FAMILY_RELATIONSHIP {
        int id PK
        int user_id FK
        int related_user_id FK
        tinyint relationship_type
        tinyint permission_level
        varchar data_access
        datetime create_time
        datetime update_time
        tinyint status
        varchar remark
    }

    RELATIONSHIP_REQUEST {
        int id PK
        int sender_id FK
        int receiver_id FK
        tinyint relationship_type
        tinyint permission_level
        varchar data_access
        varchar request_message
        tinyint request_status
        datetime create_time
        datetime update_time
        varchar remark
    }

    %% 食谱推荐相关实体
    RECIPE {
        int id PK
        varchar name
        varchar description
        varchar image
        tinyint meal_type
        int region_id FK
        int season_id FK
        datetime create_time
        datetime update_time
    }

    REGION {
        int id PK
        varchar name
        varchar code
    }

    SEASON {
        int id PK
        varchar name
        varchar code
    }

    TAGS {
        int id PK
        varchar name
    }

    %% 实体间关系
    USER ||--o{ COOKBOOK : "创建"
    USER ||--o{ NUTRIMENT : "创建"
    USER ||--o{ DIET_HISTORY : "记录"
    USER ||--o{ GOURMET : "发布"
    USER ||--o{ HEALTH_MODEL_CONFIG : "配置"
    USER ||--o{ USER_HEALTH : "记录"
    USER ||--o{ INTERACTION : "进行"
    USER ||--o{ EVALUATIONS : "评论(commenter)"
    USER ||--o{ EVALUATIONS : "回复(replier)"
    USER ||--o{ EVALUATIONS_UPVOTE : "点赞"
    USER ||--o{ MESSAGE : "接收(receiver)"
    USER ||--o{ MESSAGE : "发送(sender)"
    USER ||--o{ FAMILY_RELATIONSHIP : "拥有(user)"
    USER ||--o{ FAMILY_RELATIONSHIP : "关联到(related)"
    USER ||--o{ RELATIONSHIP_REQUEST : "发送(sender)"
    USER ||--o{ RELATIONSHIP_REQUEST : "接收(receiver)"

    CATEGORY ||--o{ COOKBOOK : "分类"
    CATEGORY ||--o{ GOURMET : "分类"

    COOKBOOK ||--o{ COOKBOOK_NUTRIMENT : "包含"
    NUTRIMENT ||--o{ COOKBOOK_NUTRIMENT : "被包含于"
    COOKBOOK ||--o{ DIET_HISTORY : "被记录"

    HEALTH_MODEL_CONFIG ||--o{ USER_HEALTH : "被记录"

    EVALUATIONS ||--o{ EVALUATIONS : "父子关系"
    EVALUATIONS ||--o{ EVALUATIONS_UPVOTE : "被点赞"

    RECIPE }o--|| REGION : "属于"
    RECIPE }o--|| SEASON : "适用于"
