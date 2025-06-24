<template>
    <div class="gourmet-container">
        <div class="page-header">
            <div class="header-content">
                <div class="title-area">
                    <h2 class="page-title">论坛精选</h2>
                    <p class="page-subtitle">分享和探索健康生活的精彩内容</p>
                </div>
                <div class="search-area">
                    <el-input 
                        size="medium" 
                        class="search-input" 
                        v-model="gourtmetQueryDto.title"
                        placeholder="搜索感兴趣的内容" 
                        clearable
                        prefix-icon="el-icon-search"
                        @clear="handleFilterClear"
                        @keyup.enter.native="fetchGourmetData">
                    </el-input>
                </div>
            </div>
        </div>
        
        <el-row :gutter="20">
            <el-col :span="18">
                <div class="category-section">
                    <span 
                        v-for="(category, index) in categories" 
                        :key="index"
                        :class="['category-tag', { active: categoryClick.id === category.id }]"
                        @click="categorySelected(category)">
                        <i v-if="categoryClick.id === category.id" class="el-icon-check"></i>
                        {{ category.name }}
                    </span>
                </div>
                
                <div v-if="gourmetList.length === 0" class="empty-state">
                    <el-empty description="暂无相关内容，换个话题试试？"></el-empty>
                    <el-button type="primary" size="small" @click="resetCategory">返回全部</el-button>
                </div>
                
                <div v-else class="gourmet-list">
                    <div 
                        v-for="(gourmet, index) in gourmetList" 
                        :key="index" 
                        class="compact-gourmet-item">
                        <div class="left">
                            <img :src="gourmet.cover" :alt="gourmet.title">
                            <div class="image-overlay">
                                <i class="el-icon-view"></i>
                            </div>
                        </div>
                        <div class="right">
                            <div class="user-info">
                                <img :src="gourmet.userAvatar" :alt="gourmet.userName">
                                <span>{{ gourmet.userName }}</span>
                                <el-tag size="mini" type="info" class="post-date">{{ timeOut(gourmet.createTime) }}</el-tag>
                            </div>
                            <div class="title" @click="readGourmet(gourmet)">{{ gourmet.title }}</div>
                            <div class="excerpt">{{ gourmet.detail.substring(0, 80) }}...</div>
                            <div class="meta">
                                <span class="upvote"><i class="el-icon-thumb"></i>{{ gourmet.upvoteCount }}</span>
                                <span class="view"><i class="el-icon-view"></i>{{ gourmet.viewCount }}</span>
                                <span class="save"><i class="el-icon-star-off"></i>{{ gourmet.saveCount }}</span>
                                <el-button size="mini" type="primary" round class="read-more" @click="readGourmet(gourmet)">
                                    阅读全文 <i class="el-icon-right"></i>
                                </el-button>
                            </div>
                        </div>
                    </div>
                    
                    <el-pagination 
                        @size-change="handleSizeChange"
                        @current-change="handleCurrentChange" 
                        :current-page="currentPage" 
                        :page-sizes="[10, 20]" 
                        :page-size="pageSize" 
                        layout="total, sizes, prev, pager, next, jumper" 
                        :total="totalItems"
                        background
                        class="pagination">
                    </el-pagination>
                </div>
            </el-col>
            
            <el-col :span="6" class="right-column">
                <div class="right-recommendations">
                    <h3 class="recommend-title"><i class="el-icon-connection"></i> 热门推荐</h3>
                    <div 
                        v-for="(gourmet, index) in topList" 
                        :key="index" 
                        class="compact-recommend-item">
                        <div class="left">
                            <img :src="gourmet.cover" :alt="gourmet.title">
                            <div class="rank-badge">{{ index + 1 }}</div>
                        </div>
                        <div class="right">
                            <div class="title" @click="readGourmet(gourmet)">{{ gourmet.title }}</div>
                            <div class="user-info">
                                <img :src="gourmet.userAvatar" :alt="gourmet.userName">
                                <span>{{ gourmet.userName }}</span>
                            </div>
                            <div class="meta">
                                <span><i class="el-icon-time"></i>{{ timeOut(gourmet.createTime) }}</span>
                                <span><i class="el-icon-view"></i>{{ gourmet.viewCount }}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </el-col>
        </el-row>
    </div>
</template>

<script>
import { timeAgo } from "@/utils/data"

export default {
    name: "Gourmet",
    data() {
        return {
            gourtmetQueryDto: {},
            gourmetList: [],
            categories: [],
            filterText: '',
            currentPage: 1,
            pageSize: 10,
            totalItems: 0,
            topList: [],
            defaultLoadItem: 5,
            categoryClick: { id: null, name: '全部' }
        }
    },
    created() {
        this.fetchCategoryData();
        this.fetchGourmetData();
        this.loadRecommend(this.defaultLoadItem);
    },
    methods: {
        timeOut(time) {
            return timeAgo(time);
        },
        loadRecommend(item) {
            this.$axios.get(`/recommend/${item}`).then(res => {
                const { data } = res;
                if (data.code === 200) {
                    this.topList = res.data.data;
                }
            }).catch(error => {
                console.log(error);
            });
        },
        readGourmet(gourmet) {
            sessionStorage.setItem('gourmetId', gourmet.id);
            this.$router.push('/gourmetDetail');
        },
        handleFilterClear() {
            this.filterText = '';
            this.fetchGourmetData();
        },
        handleSizeChange(val) {
            this.pageSize = val;
            this.currentPage = 1;
            this.fetchGourmetData();
        },
        handleCurrentChange(val) {
            this.currentPage = val;
            this.fetchGourmetData();
        },
        categorySelected(category) {
            this.categoryClick = category;
            this.gourtmetQueryDto.categoryId = category.id;
            this.currentPage = 1;
            this.fetchGourmetData();
            console.log('选择分类:', category.name, '分类ID:', category.id);
        },
        fetchCategoryData() {
            this.$axios.post('/tags/query', {}).then(res => {
                const { data } = res;
                if (data.code === 200) {
                    this.categories = res.data.data;
                    this.categories.unshift(this.categoryClick);
                }
            }).catch(error => {
                console.log(error);
            });
        },
        fetchGourmetData() {
            const queryDto = {
                current: this.currentPage,
                size: this.pageSize,
                key: this.filterText,
                ...this.gourtmetQueryDto
            };
            console.log('发送查询参数:', JSON.stringify(queryDto));
            this.$axios.post('/gourmet/queryList', queryDto).then(res => {
                const { data } = res;
                if (data.code === 200) {
                    this.gourmetList = res.data.data;
                    this.totalItems = data.total;
                    console.log('获取数据成功，条数:', this.gourmetList.length);
                }
            }).catch(error => {
                console.error('获取数据失败:', error);
                this.$message.error('获取数据失败，请稍后再试');
            });
        },
        resetCategory() {
            console.log('重置分类被调用');
            this.categoryClick = { id: null, name: '全部' };
            this.gourtmetQueryDto.title = '';
            this.gourtmetQueryDto.categoryId = null;
            this.currentPage = 1;
            this.$nextTick(() => {
                this.fetchGourmetData();
                console.log('重置完成：搜索内容已清空，分类已重置为全部');
            });
        },
    }
};
</script>

<style scoped lang="scss">
.gourmet-container {
    background-color: #f9fafb;
    padding: 30px;
    min-height: calc(100vh - 60px);
    
    .page-header {
        background: linear-gradient(135deg, #42b983, #2c9e6a);
        color: white;
        border-radius: 12px;
        padding: 25px 30px;
        margin-bottom: 30px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        
        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            
            @media (max-width: 768px) {
                flex-direction: column;
                align-items: flex-start;
                
                .search-area {
                    margin-top: 15px;
                    width: 100%;
                }
            }
            
            .title-area {
                flex: 1;
            }
            
            .search-area {
                width: 320px;
                
                .search-input {
                    .el-input__inner {
                        border-radius: 24px;
                        padding-left: 20px;
                        height: 42px;
                        border: 2px solid rgba(255, 255, 255, 0.6);
                        background-color: rgba(255, 255, 255, 0.2);
                        color: white;
                        box-shadow: 0 3px 10px rgba(0, 0, 0, 0.15);
                        transition: all 0.3s ease;
                        
                        &::placeholder {
                            color: rgba(255, 255, 255, 0.8);
                        }
                        
                        &:focus {
                            background-color: rgba(255, 255, 255, 0.3);
                            border-color: white;
                            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
                        }
                    }
                    
                    .el-input__prefix {
                        left: 12px;
                        color: white;
                        font-size: 16px;
                    }
                    
                    .el-input__suffix {
                        right: 12px;
                        
                        .el-input__suffix-inner {
                            .el-input__icon {
                                color: white;
                                font-size: 16px;
                                
                                &:hover {
                                    transform: scale(1.1);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    .page-title {
        font-size: 24px;
        font-weight: 600;
        margin: 0 0 10px;
        color: white;
    }
    
    .page-subtitle {
        font-size: 14px;
        margin: 0;
        opacity: 0.9;
    }
    
    .category-section {
        margin-bottom: 25px;
        
        .category-tag {
            display: inline-block;
            padding: 8px 18px;
            border-radius: 20px;
            margin-right: 10px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
            background-color: #f1f5f9;
            color: #4b5563;
            margin-bottom: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.04);
            font-weight: 500;
            
            i {
                margin-right: 4px;
            }
            
            &:hover {
                background-color: #e2e8f0;
                transform: translateY(-1px);
                box-shadow: 0 3px 6px rgba(0,0,0,0.08);
            }
            
            &.active {
                background-color: #42b983;
                color: white;
                box-shadow: 0 3px 8px rgba(66, 185, 131, 0.25);
                transform: translateY(-2px);
            }
        }
    }
    
    .empty-state {
        background: white;
        padding: 40px 0;
        border-radius: 12px;
        box-shadow: 0 1px 5px rgba(0,0,0,0.08);
        text-align: center;
        
        .el-button {
            margin-top: 15px;
            background-color: #42b983;
            border-color: #42b983;
            
            &:hover {
                background-color: #2c9e6a;
                border-color: #2c9e6a;
            }
        }
    }
    
    .compact-gourmet-item {
        display: flex;
        margin-bottom: 20px;
        padding: 16px;
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        transition: all 0.3s ease;
        
        &:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
            
            .image-overlay {
                opacity: 1;
            }
            
            .title {
                color: #42b983;
            }
        }
        
        .left {
            flex-shrink: 0;
            position: relative;
            overflow: hidden;
            border-radius: 8px;
            
            img {
                width: 180px;
                height: 120px;
                border-radius: 8px;
                object-fit: cover;
                transition: all 0.5s ease;
            }
            
            .image-overlay {
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0,0,0,0.4);
                opacity: 0;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                
                i {
                    font-size: 24px;
                    color: white;
                    background: rgba(15, 117, 63, 0.8);
                    width: 50px;
                    height: 50px;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }
            }
        }
        
        .right {
            flex: 1;
            padding-left: 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            
            .user-info {
                display: flex;
                align-items: center;
                margin-bottom: 8px;
                
                img {
                    width: 24px;
                    height: 24px;
                    border-radius: 50%;
                    margin-right: 8px;
                    border: 2px solid #fff;
                    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                }
                
                span {
                    font-size: 14px;
                    color: #4b5563;
                    font-weight: 500;
                }
                
                .post-date {
                    margin-left: 10px;
                    font-size: 12px;
                    background-color: #f3f4f6;
                    color: #6b7280;
                    border: none;
                }
            }
            
            .title {
                font-size: 18px;
                font-weight: 700;
                margin-bottom: 8px;
                color: #1f2937;
                cursor: pointer;
                line-height: 1.4;
                transition: all 0.3s ease;
                
                &:hover {
                    color: #42b983;
                }
            }
            
            .excerpt {
                font-size: 14px;
                color: #6b7280;
                margin-bottom: 12px;
                line-height: 1.5;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }
            
            .meta {
                display: flex;
                font-size: 13px;
                color: #6b7280;
                align-items: center;
                
                span {
                    margin-right: 16px;
                    display: flex;
                    align-items: center;
                    
                    i {
                        margin-right: 5px;
                        font-size: 14px;
                    }
                    
                    &.upvote i {
                        color: #ef4444;
                    }
                    
                    &.view i {
                        color: #3b82f6;
                    }
                    
                    &.save i {
                        color: #f59e0b;
                    }
                }
                
                .read-more {
                    margin-left: auto;
                    background-color: #42b983;
                    border-color: #42b983;
                    padding: 6px 15px;
                    
                    i {
                        margin-left: 4px;
                        font-weight: bold;
                    }
                    
                    &:hover {
                        background-color: #2c9e6a;
                    }
                }
            }
        }
    }
    
    .pagination {
        margin-top: 30px;
        padding: 20px 0;
        background: white;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        display: flex;
        justify-content: center;
        
        .el-pagination.is-background .el-pager li:not(.disabled).active {
            background-color: #42b983;
        }
    }
    
    .right-column {
        padding-left: 15px !important;
    }
    
    .right-recommendations {
        padding: 20px;
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        position: sticky;
        top: 80px;
        
        .recommend-title {
            font-size: 18px;
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 1px solid #eee;
            color: #1f2937;
            font-weight: 700;
            display: flex;
            align-items: center;
            
            i {
                color: #0f753f;
                margin-right: 8px;
                font-size: 20px;
            }
        }
    
        .compact-recommend-item {
            display: flex;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #f1f5f9;
            position: relative;
            
            &:hover {
                .title {
                    color: #0f753f;
                }
                
                .rank-badge {
                    background-color: #0f753f;
                }
            }
            
            &:last-child {
                border-bottom: none;
                margin-bottom: 0;
                padding-bottom: 0;
            }
            
            .left {
                flex-shrink: 0;
                position: relative;
                
                img {
                    width: 90px;
                    height: 70px;
                    border-radius: 6px;
                    object-fit: cover;
                }
                
                .rank-badge {
                    position: absolute;
                    top: -8px;
                    left: -8px;
                    width: 24px;
                    height: 24px;
                    border-radius: 50%;
                    background-color: #f59e0b;
                    color: white;
                    font-weight: bold;
                    font-size: 12px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    transition: all 0.3s ease;
                    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                }
            }
            
            .right {
                flex: 1;
                padding-left: 12px;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                
                .title {
                    font-size: 15px;
                    font-weight: 600;
                    margin-bottom: 8px;
                    line-height: 1.3;
                    cursor: pointer;
                    color: #1f2937;
                    display: -webkit-box;
                    -webkit-line-clamp: 2;
                    -webkit-box-orient: vertical;
                    overflow: hidden;
                    transition: all 0.3s ease;
                }
                
                .user-info {
                    display: flex;
                    align-items: center;
                    margin-bottom: 6px;
                    
                    img {
                        width: 18px;
                        height: 18px;
                        border-radius: 50%;
                        margin-right: 6px;
                        border: 1px solid #fff;
                        box-shadow: 0 1px 2px rgba(0,0,0,0.1);
                    }
                    
                    span {
                        font-size: 12px;
                        color: #6b7280;
                    }
                }
                
                .meta {
                    font-size: 12px;
                    color: #9ca3af;
                    display: flex;
                    
                    span {
                        margin-right: 10px;
                        display: flex;
                        align-items: center;
                        
                        i {
                            margin-right: 3px;
                            font-size: 12px;
                            
                            &.el-icon-time {
                                color: #059669;
                            }
                            
                            &.el-icon-view {
                                color: #3b82f6;
                            }
                        }
                    }
                }
            }
        }
    }
}
</style>