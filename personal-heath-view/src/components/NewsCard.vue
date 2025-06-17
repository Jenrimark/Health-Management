<template>
    <div class="news-card" @click="handleClick">
      <div class="cover">
        <img :src="news.coverUrl" :alt="news.title">
        <div v-if="news.recommendScore > 0" class="recommend-badge">
          推荐 {{ (news.recommendScore * 100).toFixed(0) }}%
        </div>
      </div>
      <div class="content">
        <h3 class="title">{{ news.title }}</h3>
        <div class="meta">
          <span class="tag">{{ news.tagName }}</span>
          <span class="read-count">
            <i class="el-icon-view"></i> {{ news.readCount }}
          </span>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    props: {
      news: {
        type: Object,
        required: true
      }
    },
    methods: {
      handleClick() {
        this.$emit('click', this.news)
      }
    }
  }
  </script>
  
  <style scoped>
  .news-card {
    margin-bottom: 20px;
    cursor: pointer;
    transition: all 0.3s;
    border-radius: 4px;
    overflow: hidden;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  }
  
  .news-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 5px 15px 0 rgba(0, 0, 0, 0.2);
  }
  
  .cover {
    position: relative;
    height: 0;
    padding-bottom: 60%;
    overflow: hidden;
  }
  
  .cover img {
    position: absolute;
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  .recommend-badge {
    position: absolute;
    top: 10px;
    right: 10px;
    background-color: #f56c6c;
    color: white;
    padding: 2px 8px;
    border-radius: 10px;
    font-size: 12px;
  }
  
  .content {
    padding: 15px;
  }
  
  .title {
    margin: 0 0 10px 0;
    font-size: 16px;
    line-height: 1.4;
    height: 44px;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;   
    -webkit-box-orient: vertical;
  }
  
  .meta {
    display: flex;
    justify-content: space-between;
    color: #909399;
    font-size: 12px;
  }
  
  .tag {
    background-color: #f0f7ff;
    color: #409EFF;
    padding: 2px 6px;
    border-radius: 3px;
  }
  </style>