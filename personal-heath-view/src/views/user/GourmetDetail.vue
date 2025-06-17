<template>
    <div class="gourmet-detail-container">
      <!-- 返回按钮 -->
      <div class="back-button" @click="$router.push('/gourmet')">
        <i class="el-icon-back"></i>
        返回论坛首页
      </div>
  
      <el-row class="main-content">
        <!-- 左侧内容区 -->
        <el-col :span="16" class="left-content">
          <!-- 固定标题区 -->
          <div class="sticky-header">
            <h1 class="title">{{ gourmet.title }}</h1>
            <div class="meta-info">
              <div class="author-info">
                <img :src="gourmet.userAvatar" alt="作者头像" class="avatar">
                <span class="username">{{ gourmet.userName }}</span>
              </div>
              <div class="stats">
                <span class="stat-item">
                  <i class="el-icon-time"></i>
                  {{ gourmet.createTime }}
                </span>
                <span class="stat-item">
                  <i class="el-icon-discount"></i>
                  {{ gourmet.upvoteCount }} 点赞
                </span>
                <span class="stat-item">
                  <i class="el-icon-view"></i>
                  {{ gourmet.viewCount }} 浏览
                </span>
                <span class="stat-item">
                  <i class="el-icon-star-off"></i>
                  {{ gourmet.saveCount }} 收藏
                </span>
              </div>
            </div>
          </div>
  
          <!-- 正文内容 -->
          <div class="content" v-html="gourmet.content"></div>
  
          <!-- 互动操作区 -->
          <div class="action-buttons">
            <el-tooltip :content="upvoteStatus ? '取消点赞' : '点赞这篇帖子'" placement="top">
              <el-button 
                :type="upvoteStatus ? 'primary' : ''" 
                @click="opeationUpvote"
                class="action-button"
              >
                <i class="el-icon-discount"></i>
                点赞 {{ gourmet.upvoteCount }}
              </el-button>
            </el-tooltip>
  
            <el-tooltip :content="saveStatus ? '取消收藏' : '收藏这篇帖子'" placement="top">
              <el-button 
                :type="saveStatus ? 'primary' : ''" 
                @click="opeationSave"
                class="action-button"
              >
                <i class="el-icon-star-off"></i>
                收藏 {{ gourmet.saveCount }}
              </el-button>
            </el-tooltip>
          </div>
  
          <!-- 评论组件 -->
          <div class="comments-section">
            <Evaluations :contentId="gourmetId" contentType="NEWS" />
          </div>
        </el-col>
  
        <!-- 右侧边栏 -->
        <el-col :span="8" class="right-sidebar">
  
          <!-- 评分区 -->
          <div class="rating-section">
            <h3 class="sidebar-title">
              <i class="el-icon-data-line"></i>
              评分信息
            </h3>
            
            <!-- 评分表单 -->
            <div v-if="!ratingStatus" class="rating-form">
              <p class="rating-tip">轻触星星为这篇帖子评分</p>
              <el-rate 
                v-model="ratingScore" 
                :colors="['#99A9BF', '#F7BA2A', '#FF9900']"
                @change="ratingEvent"
              ></el-rate>
            </div>
            
            <!-- 总评分 -->
            <div class="total-rating">
              <h4>当前评分</h4>
              <el-rate 
                v-model="gourmet.rating" 
                disabled 
                show-score 
                text-color="#FF9900"
                score-template="{value} 分"
              ></el-rate>
            </div>
            
            <!-- 用户评分列表 -->
            <div class="user-ratings">
              <h4>最新评分</h4>
              <div v-if="ratingVos.length === 0" class="empty-ratings">
                <el-empty description="暂无评分"></el-empty>
              </div>
              <div 
                v-for="(ratingVO, m) in ratingVos" 
                :key="m" 
                class="user-rating-item"
              >
                <div class="user-info">
                  <img :src="ratingVO.userAvatar" alt="用户头像">
                  <span>{{ ratingVO.userName }}</span>
                </div>
                <div class="rating-info">
                  <el-rate 
                    v-model="ratingVO.score" 
                    disabled 
                    show-score 
                    text-color="#FF9900"
                    score-template="{value} 分"
                  ></el-rate>
                  <span class="rating-time">{{ ratingVO.createTime }}</span>
                </div>
              </div>
            </div>
          </div>
        </el-col>
      </el-row>
    </div>
  </template>
  
  <script>
  import Evaluations from "@/components/Evaluations"
  
  export default {
    components: { Evaluations },
    name: "GourmetDetail",
    data() {
      return {
        gourmetId: null,
        gourmet: {
          rating: 0
        },
        ratingScore: 0,
        recommendGourmet: [],
        ratingVos: [],
        upvoteStatus: false,
        saveStatus: false,
        ratingStatus: false
      }
    },
    created() {
      this.loadGourmetId();
      this.fetchTopGourmet();
    },
    methods: {
      fetchRatingData(contentId) {
        const interactionQueryDto = {
          contentId,
          current: 1,
          size: 3
        }
        this.$axios.post(`/interaction/queryUserRating`, interactionQueryDto).then(res => {
          const { data } = res;
          if (data.code === 200) {
            this.ratingVos = data.data;
          }
        }).catch(error => {
          console.log("查询评分信息异常：", error);
        })
      },
      ratingEvent() {
        this.$axios.post(`/interaction/ratingOperation/${this.gourmetId}/${this.ratingScore}`).then(res => {
          const { data } = res;
          if (data.code === 200) {
            this.gourmet = data.data[0];
            this.dealRating(this.gourmet);
            this.$message.success('评分成功');
            this.ratingStatus = true;
            this.fetchRatingData(this.gourmetId);
          } else {
            this.$message.error(data.msg);
          }
        }).catch(error => {
          console.log("评分操作异常：", error);
        })
      },
      fetchUpvoteOperation(contentId) {
        this.$axios.get(`/interaction/upvoteStatus/${contentId}`).then(res => {
          const { data } = res;
          if (data.code === 200) {
            this.upvoteStatus = data.data > 0;
          }
        }).catch(error => {
          console.log("查询点赞状态异常：", error);
        })
      },
      fetchRatingOperation(contentId) {
        this.$axios.get(`/interaction/ratingStatus/${contentId}`).then(res => {
          const { data } = res;
          if (data.code === 200) {
            this.ratingStatus = data.data > 0;
          }
        }).catch(error => {
          console.log("查询评分状态异常：", error);
        })
      },
      fetchSaveOperation(contentId) {
        this.$axios.get(`/interaction/saveStatus/${contentId}`).then(res => {
          const { data } = res;
          if (data.code === 200) {
            this.saveStatus = data.data > 0;
          }
        }).catch(error => {
          console.log("查询收藏状态异常：", error);
        })
      },
      opeationSave() {
        this.$axios.post(`/interaction/saveOperation/${this.gourmetId}`).then(res => {
          const { data } = res;
          if (data.code === 200) {
            if (data.data > 0) {
              this.gourmet.saveCount += 1;
              this.$message.success('收藏成功');
            } else {
              this.gourmet.saveCount -= 1;
              this.$message.success('已取消收藏');
            }
            this.saveStatus = data.data > 0;
          }
        }).catch(error => {
          console.log("收藏操作异常：", error);
        })
      },
      opeationUpvote() {
        this.$axios.post(`/interaction/upvoteOperation/${this.gourmetId}`).then(res => {
          const { data } = res;
          if (data.code === 200) {
            if (data.data > 0) {
              this.gourmet.upvoteCount += 1;
              this.$message.success('点赞成功');
            } else {
              this.gourmet.upvoteCount -= 1;
              this.$message.success('已取消点赞');
            }
            this.upvoteStatus = data.data > 0;
          }
        }).catch(error => {
          console.log("点赞操作异常：", error);
        })
      },
      readGourmet(gourmet) {
        sessionStorage.setItem('gourmetId', gourmet.id);
        this.$router.go(0); // 刷新页面加载新内容
      },
      loadGourmetId() {
        this.gourmetId = Number(sessionStorage.getItem('gourmetId'));
        this.fetchGourmetById(this.gourmetId);
        this.viewOperation(this.gourmetId);
        this.fetchUpvoteOperation(this.gourmetId);
        this.fetchSaveOperation(this.gourmetId);
        this.fetchRatingOperation(this.gourmetId);
        this.fetchRatingData(this.gourmetId);
      },
      dealRating(gourmet) {
        this.gourmet.rating = gourmet.rating === null ? 0 : gourmet.rating;
      },
      fetchGourmetById(gourmetId) {
        this.$axios.get(`/gourmet/${gourmetId}`).then(res => {
          const { data } = res;
          if (data.code === 200) {
            this.gourmet = data.data[0];
            this.dealRating(this.gourmet);
          }
        }).catch(error => {
          console.log("通过ID查询异常：", error);
        })
      },
      viewOperation(contentId) {
        this.$axios.post(`/interaction/viewOperation/${contentId}`).then(res => {
          const { data } = res;
          if (data.code === 200) {
            this.gourmet.viewCount += 1;
          }
        }).catch(error => {
          console.log("浏览操作异常：", error);
        })
      },
      
    }
  };
  </script>
  
  <style scoped lang="scss">
  .gourmet-detail-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    
    .back-button {
      display: inline-flex;
      align-items: center;
      padding: 8px 16px;
      margin-bottom: 20px;
      background-color: #f5f7fa;
      border-radius: 4px;
      color: #606266;
      cursor: pointer;
      transition: all 0.3s;
      
      &:hover {
        background-color: #e6e9ed;
        color: #409EFF;
      }
      
      i {
        margin-right: 5px;
      }
    }
    
    .main-content {
      display: flex;
    }
    
    .left-content {
      padding-right: 20px;
      border-right: 1px solid #ebeef5;
      
      .sticky-header {
        position: sticky;
        top: 60px;
        z-index: 100;
        background-color: #fff;
        padding: 20px 0;
        border-bottom: 1px solid #ebeef5;
        
        .title {
          font-size: 28px;
          font-weight: 600;
          margin: 0 0 15px 0;
          color: #303133;
          line-height: 1.3;
        }
        
        .meta-info {
          display: flex;
          align-items: center;
          justify-content: space-between;
          
          .author-info {
            display: flex;
            align-items: center;
            
            .avatar {
              width: 30px;
              height: 30px;
              border-radius: 50%;
              margin-right: 10px;
              object-fit: cover;
            }
            
            .username {
              font-size: 14px;
              color: #606266;
            }
          }
          
          .stats {
            display: flex;
            align-items: center;
            
            .stat-item {
              display: flex;
              align-items: center;
              margin-left: 15px;
              font-size: 13px;
              color: #909399;
              
              i {
                margin-right: 5px;
                font-size: 14px;
              }
            }
          }
        }
      }
      
      .content {
        padding: 20px 0;
        line-height: 1.8;
        font-size: 15px;
        color: #303133;
        
        >>> img {
          max-width: 100%;
          height: auto;
          border-radius: 4px;
        }
        
        >>> p {
          margin-bottom: 15px;
        }
      }
      
      .action-buttons {
        display: flex;
        justify-content: center;
        margin: 40px 0;
        padding: 20px 0;
        border-top: 1px solid #ebeef5;
        border-bottom: 1px solid #ebeef5;
        
        .action-button {
          margin: 0 15px;
          padding: 10px 20px;
          font-size: 14px;
          
          i {
            margin-right: 5px;
          }
        }
      }
      
      .comments-section {
        margin-top: 30px;
      }
    }
    
    .right-sidebar {
      padding-left: 20px;
      position: sticky;
      top: 60px;
      height: fit-content;
      
      .sidebar-title {
        font-size: 18px;
        color: #303133;
        margin: 0 0 15px 0;
        padding-bottom: 10px;
        border-bottom: 1px solid #ebeef5;
        
        i {
          margin-right: 8px;
          color: #409EFF;
        }
      }
      
      .recommend-section {
        margin-bottom: 30px;
        
        .recommend-item {
          display: flex;
          padding: 12px 0;
          border-bottom: 1px dashed #ebeef5;
          cursor: pointer;
          transition: all 0.3s;
          
          &:hover {
            background-color: #f5f7fa;
            
            .title {
              color: #409EFF;
            }
          }
          
          .cover {
            flex-shrink: 0;
            width: 80px;
            height: 60px;
            margin-right: 12px;
            border-radius: 4px;
            overflow: hidden;
            
            img {
              width: 100%;
              height: 100%;
              object-fit: cover;
            }
          }
          
          .info {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            
            .title {
              font-size: 14px;
              font-weight: 500;
              margin: 0;
              line-height: 1.4;
              display: -webkit-box;
              -webkit-box-orient: vertical;
              overflow: hidden;
              transition: color 0.3s;
            }
            
            .meta {
              display: flex;
              justify-content: space-between;
              font-size: 12px;
              color: #909399;
              
              .author {
                display: flex;
                align-items: center;
                
                img {
                  width: 16px;
                  height: 16px;
                  border-radius: 50%;
                  margin-right: 5px;
                }
              }
              
              .stats {
                i {
                  margin-left: 8px;
                  
                  &:first-child {
                    margin-left: 0;
                  }
                }
              }
            }
          }
        }
      }
      
      .rating-section {
        .rating-form {
          margin: 20px 0;
          text-align: center;
          
          .rating-tip {
            font-size: 13px;
            color: #909399;
            margin-bottom: 10px;
          }
          
          >>> .el-rate {
            font-size: 24px;
          }
        }
        
        .total-rating {
          background-color: #f5f7fa;
          border-radius: 8px;
          padding: 15px;
          margin-bottom: 20px;
          text-align: center;
          
          h4 {
            margin: 0 0 10px 0;
            font-size: 16px;
            color: #303133;
          }
          
          >>> .el-rate {
            font-size: 20px;
          }
        }
        
        .user-ratings {
          h4 {
            font-size: 16px;
            color: #303133;
            margin: 0 0 15px 0;
          }
          
          .user-rating-item {
            padding: 12px 0;
            border-bottom: 1px dashed #ebeef5;
            
            .user-info {
              display: flex;
              align-items: center;
              margin-bottom: 8px;
              
              img {
                width: 24px;
                height: 24px;
                border-radius: 50%;
                margin-right: 8px;
              }
              
              span {
                font-size: 13px;
                color: #606266;
              }
            }
            
            .rating-info {
              display: flex;
              justify-content: space-between;
              align-items: center;
              
              >>> .el-rate {
                font-size: 16px;
              }
              
              .rating-time {
                font-size: 12px;
                color: #909399;
              }
            }
          }
        }
        
        .empty-ratings {
          padding: 20px 0;
          
          >>> .el-empty__description p {
            font-size: 13px;
            color: #909399;
          }
        }
      }
    }
  }
  </style>