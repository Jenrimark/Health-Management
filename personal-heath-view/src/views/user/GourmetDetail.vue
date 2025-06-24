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
                  {{ gourmet.viewCount }} 精选
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
            
            <!-- 用户已评分显示 -->
            <div v-else class="user-rated">
              <div class="rating-current">
                <i class="el-icon-success"></i> 
                <span>您已评分 {{ userCurrentRating }} 分</span>
              </div>
              <p class="rating-tip-small">评分一经提交无法修改</p>
            </div>
            
            <!-- 总评分 -->
            <div class="total-rating">
              <h4>当前评分</h4>
              <div class="rating-value">
                <el-rate 
                  v-model="gourmet.rating" 
                  disabled 
                  show-score 
                  text-color="#FF9900"
                  score-template="{value} 分"
                ></el-rate>
              </div>
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
                  <div class="stars">
                    <el-rate 
                      v-model="ratingVO.score" 
                      disabled 
                      show-score 
                      text-color="#FF9900"
                      score-template="{value} 分"
                    ></el-rate>
                  </div>
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
        userCurrentRating: 0,
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
            // 更新用户当前评分
            this.userCurrentRating = this.ratingScore;
            this.ratingStatus = true;
            this.fetchRatingData(this.gourmetId);
          } else {
            this.$message.error(data.msg || '评分失败，请稍后再试');
          }
        }).catch(error => {
          console.log("评分操作异常：", error);
          this.$message.error('评分操作异常，请稍后再试');
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
            if (this.ratingStatus) {
              // 如果用户已评分，获取当前评分值
              this.fetchUserCurrentRating(contentId);
            }
          }
        }).catch(error => {
          console.log("查询评分状态异常：", error);
        })
      },
      fetchUserCurrentRating(contentId) {
        this.$axios.get(`/interaction/userCurrentRating/${contentId}`).then(res => {
          const { data } = res;
          if (data.code === 200) {
            this.userCurrentRating = data.data;
            this.ratingScore = this.userCurrentRating;
          }
        }).catch(error => {
          console.log("获取用户当前评分异常：", error);
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
          console.log("精选操作异常：", error);
        })
      },
      
    }
  };
  </script>
  
  <style scoped lang="scss">
  .gourmet-detail-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 30px;
    background-color: #fff;
    border-radius: 12px;
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
    
    .back-button {
      display: inline-flex;
      align-items: center;
      padding: 10px 18px;
      margin-bottom: 25px;
      background-color: rgba(66, 185, 131, 0.1);
      border-radius: 8px;
      color: #42b983;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s;
      border: 1px solid transparent;
      
      &:hover {
        background-color: #42b983;
        color: white;
        transform: translateX(-5px);
        box-shadow: 0 4px 10px rgba(66, 185, 131, 0.2);
      }
      
      i {
        margin-right: 8px;
        font-size: 16px;
        transition: transform 0.3s;
      }
    }
    
    .main-content {
      display: flex;
    }
    
    .left-content {
      padding-right: 30px;
      border-right: 1px solid #ebeef5;
      
      .sticky-header {
        position: sticky;
        top: 60px;
        z-index: 100;
        background-color: #fff;
        padding: 20px 0;
        border-bottom: 1px solid rgba(66, 185, 131, 0.2);
        
        .title {
          font-size: 32px;
          font-weight: 700;
          margin: 0 0 20px 0;
          color: #303133;
          line-height: 1.4;
          position: relative;
          padding-left: 15px;
          
          &::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 4px;
            background: linear-gradient(to bottom, #42b983, #2c9e6a);
            border-radius: 4px;
          }
        }
        
        .meta-info {
          display: flex;
          align-items: center;
          justify-content: space-between;
          background-color: #f9fafb;
          padding: 12px 15px;
          border-radius: 8px;
          
          .author-info {
            display: flex;
            align-items: center;
            
            .avatar {
              width: 40px;
              height: 40px;
              border-radius: 50%;
              margin-right: 12px;
              object-fit: cover;
              border: 2px solid white;
              box-shadow: 0 2px 6px rgba(66, 185, 131, 0.2);
              transition: transform 0.3s;
              
              &:hover {
                transform: scale(1.1);
              }
            }
            
            .username {
              font-size: 16px;
              font-weight: 500;
              color: #42b983;
            }
          }
          
          .stats {
            display: flex;
            align-items: center;
            
            .stat-item {
              display: flex;
              align-items: center;
              margin-left: 18px;
              font-size: 14px;
              color: #606266;
              padding: 6px 12px;
              border-radius: 20px;
              background-color: rgba(255, 255, 255, 0.7);
              transition: all 0.3s;
              
              &:hover {
                background-color: rgba(66, 185, 131, 0.1);
                transform: translateY(-2px);
              }
              
              i {
                margin-right: 6px;
                font-size: 16px;
                color: #42b983;
              }
            }
          }
        }
      }
      
      .content {
        padding: 30px 0;
        line-height: 1.8;
        font-size: 16px;
        color: #303133;
        
        >>> img {
          max-width: 100%;
          height: auto;
          border-radius: 8px;
          box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
          margin: 15px 0;
          transition: transform 0.3s;
          
          &:hover {
            transform: scale(1.01);
          }
        }
        
        >>> p {
          margin-bottom: 20px;
          line-height: 1.8;
        }
        
        >>> h1, >>> h2, >>> h3, >>> h4 {
          margin-top: 30px;
          margin-bottom: 15px;
          color: #2c3e50;
          font-weight: 600;
        }
        
        >>> a {
          color: #42b983;
          text-decoration: none;
          border-bottom: 1px dotted #42b983;
          transition: all 0.3s;
          
          &:hover {
            color: #2c9e6a;
            border-bottom: 1px solid #2c9e6a;
          }
        }
        
        >>> blockquote {
          border-left: 4px solid #42b983;
          padding: 10px 15px;
          color: #606266;
          background-color: rgba(66, 185, 131, 0.05);
          margin: 20px 0;
          border-radius: 0 4px 4px 0;
        }
      }
      
      .action-buttons {
        display: flex;
        justify-content: center;
        margin: 40px 0;
        padding: 25px 0;
        border-top: 1px solid #ebeef5;
        border-bottom: 1px solid #ebeef5;
        
        .action-button {
          margin: 0 15px;
          padding: 12px 25px;
          font-size: 15px;
          border-radius: 25px;
          transition: all 0.3s;
          border: 2px solid transparent;
          
          &:not(.el-button--primary) {
            background-color: #f8f9fa;
            color: #42b983;
            border-color: #e4e7ed;
            
            &:hover {
              border-color: #42b983;
              background-color: rgba(66, 185, 131, 0.1);
              transform: translateY(-2px);
            }
          }
          
          &.el-button--primary {
            background-color: #42b983;
            border-color: #42b983;
            
            &:hover {
              background-color: #2c9e6a;
              border-color: #2c9e6a;
              transform: translateY(-2px);
              box-shadow: 0 4px 10px rgba(66, 185, 131, 0.3);
            }
          }
          
          i {
            margin-right: 8px;
            font-size: 16px;
          }
        }
      }
      
      .comments-section {
        margin-top: 40px;
      }
    }
    
    .right-sidebar {
      padding-left: 30px;
      position: sticky;
      top: 60px;
      height: fit-content;
      
      .sidebar-title {
        font-size: 20px;
        color: #303133;
        margin: 0 0 20px 0;
        padding-bottom: 12px;
        border-bottom: 1px solid #ebeef5;
        position: relative;
        
        &::after {
          content: '';
          position: absolute;
          bottom: -1px;
          left: 0;
          width: 50px;
          height: 3px;
          background-color: #42b983;
          border-radius: 3px;
        }
        
        i {
          margin-right: 10px;
          color: #42b983;
        }
      }
      
      .recommend-section {
        margin-bottom: 40px;
        
        .recommend-item {
          display: flex;
          padding: 15px;
          border-radius: 8px;
          margin-bottom: 15px;
          cursor: pointer;
          transition: all 0.3s;
          border: 1px solid transparent;
          
          &:hover {
            background-color: #f9fafb;
            transform: translateY(-3px);
            border-color: rgba(66, 185, 131, 0.2);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.05);
            
            .title {
              color: #42b983;
            }
            
            .cover img {
              transform: scale(1.05);
            }
          }
          
          .cover {
            flex-shrink: 0;
            width: 90px;
            height: 70px;
            margin-right: 15px;
            border-radius: 6px;
            overflow: hidden;
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
            
            img {
              width: 100%;
              height: 100%;
              object-fit: cover;
              transition: transform 0.5s;
            }
          }
          
          .info {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            
            .title {
              font-size: 15px;
              font-weight: 600;
              margin: 0;
              line-height: 1.4;
              display: -webkit-box;
              -webkit-box-orient: vertical;
              -webkit-line-clamp: 2;
              overflow: hidden;
              transition: color 0.3s;
            }
            
            .meta {
              display: flex;
              justify-content: space-between;
              font-size: 12px;
              color: #909399;
              margin-top: 8px;
              
              .author {
                display: flex;
                align-items: center;
                
                img {
                  width: 20px;
                  height: 20px;
                  border-radius: 50%;
                  margin-right: 5px;
                  border: 1px solid white;
                }
              }
              
              .stats {
                i {
                  margin-left: 8px;
                  color: #42b983;
                  
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
        background-color: #f9fafb;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
        
        .rating-form {
          margin: 20px 0;
          text-align: center;
          
          .rating-tip {
            font-size: 14px;
            color: #606266;
            margin-bottom: 12px;
          }
          
          >>> .el-rate {
            font-size: 24px;
            transition: transform 0.3s;
            
            &:hover {
              transform: scale(1.05);
            }
          }
        }
        
        .user-rated {
          margin: 20px 0;
          text-align: center;
          
          .rating-current {
            padding: 12px 20px;
            background-color: rgba(66, 185, 131, 0.1);
            border-radius: 8px;
            display: inline-block;
            margin-bottom: 10px;
            
            i {
              color: #42b983;
              font-size: 18px;
              margin-right: 8px;
              vertical-align: middle;
            }
            
            span {
              font-size: 16px;
              font-weight: 600;
              color: #303133;
              vertical-align: middle;
            }
          }
          
          .rating-tip-small {
            font-size: 12px;
            color: #909399;
            margin-top: 8px;
          }
        }
        
        .total-rating {
          background-color: white;
          border-radius: 10px;
          padding: 20px;
          margin-bottom: 25px;
          text-align: center;
          box-shadow: 0 3px 8px rgba(0, 0, 0, 0.05);
          
          h4 {
            margin: 0 0 15px 0;
            font-size: 18px;
            color: #303133;
            position: relative;
            display: inline-block;
            
            &::after {
              content: '';
              position: absolute;
              bottom: -5px;
              left: 50%;
              transform: translateX(-50%);
              width: 30px;
              height: 2px;
              background-color: #42b983;
            }
          }
          
          >>> .el-rate {
            font-size: 22px;
          }
          
          >>> .el-rate__text {
            font-size: 20px;
            font-weight: 600;
            color: #ff9900;
            margin-left: 10px;
            vertical-align: middle;
          }
        }
        
        .user-ratings {
          h4 {
            font-size: 18px;
            color: #303133;
            margin: 0 0 20px 0;
            position: relative;
            display: inline-block;
            
            &::after {
              content: '';
              position: absolute;
              bottom: -5px;
              left: 0;
              width: 30px;
              height: 2px;
              background-color: #42b983;
            }
          }
          
          .user-rating-item {
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 8px;
            background-color: white;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.04);
            transition: all 0.3s;
            position: relative;
            border-left: 3px solid #42b983;
            
            &:hover {
              transform: translateY(-3px);
              box-shadow: 0 5px 10px rgba(0, 0, 0, 0.08);
            }
            
            .user-info {
              display: flex;
              align-items: center;
              margin-bottom: 10px;
              
              img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                margin-right: 10px;
                border: 2px solid white;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s;
                
                &:hover {
                  transform: scale(1.1);
                }
              }
              
              span {
                font-size: 16px;
                font-weight: 500;
                color: #42b983;
                position: relative;
                
                &:after {
                  content: '';
                  position: absolute;
                  bottom: -3px;
                  left: 0;
                  width: 0;
                  height: 1px;
                  background-color: #42b983;
                  transition: width 0.3s;
                }
                
                &:hover:after {
                  width: 100%;
                }
              }
            }
            
            .rating-info {
              display: flex;
              justify-content: space-between;
              align-items: center;
              
              >>> .el-rate {
                font-size: 18px;
              }
              
              >>> .el-rate__text {
                font-size: 16px;
                font-weight: 600;
                color: #ff9900;
              }
              
              .rating-time {
                font-size: 13px;
                color: #909399;
                padding: 4px 10px;
                background-color: #f5f7fa;
                border-radius: 15px;
                transition: all 0.3s;
                
                &:hover {
                  background-color: rgba(66, 185, 131, 0.1);
                  color: #42b983;
                }
              }
            }
          }
        }
        
        .empty-ratings {
          padding: 20px 0;
          
          >>> .el-empty__description p {
            font-size: 14px;
            color: #909399;
          }
        }
      }
    }
  }
  </style>