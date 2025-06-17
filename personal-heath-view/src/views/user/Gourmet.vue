<template>
    <div class="gourmet-container">
        <el-row :gutter="20">
            <el-col :span="18">
                <div class="header-section">
                    <h1 class="page-title">论坛合集</h1>
                    <el-input 
                        size="medium" 
                        class="search-input" 
                        v-model="gourtmetQueryDto.title"
                        placeholder="搜索帖子" 
                        clearable 
                        @clear="handleFilterClear">
                        <el-button 
                            slot="append" 
                            @click="fetchGourmetData" 
                            icon="el-icon-search">
                        </el-button>
                    </el-input>
                </div>
                
                <div class="category-section">
                    <span 
                        v-for="(category, index) in categories" 
                        :key="index"
                        :class="['category-tag', { active: categoryClick.id === category.id }]"
                        @click="categorySelected(category)">
                        {{ category.name }}
                    </span>
                </div>
                
                <div v-if="gourmetList.length === 0" class="empty-state">
                    <el-empty description="暂无相关帖子"></el-empty>
                </div>
                
                <div v-else class="gourmet-list">
                    <div 
                        v-for="(gourmet, index) in gourmetList" 
                        :key="index" 
                        class="compact-gourmet-item">
                        <div class="left">
                            <img :src="gourmet.cover">
                        </div>
                        <div class="right">
                            <div class="user-info">
                                <img :src="gourmet.userAvatar" alt="">
                                <span>{{ gourmet.userName }}</span>
                            </div>
                            <div class="title" @click="readGourmet(gourmet)">{{ gourmet.title }}</div>
                            <div class="excerpt">{{ gourmet.detail.substring(0, 60) }}...</div>
                            <div class="meta">
                                <span>{{ gourmet.createTime }}</span>
                                <span><i class="el-icon-discount"></i>{{ gourmet.upvoteCount }}</span>
                                <span><i class="el-icon-view"></i>{{ gourmet.viewCount }}</span>
                                <span><i class="el-icon-star-off"></i>{{ gourmet.saveCount }}</span>
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
                        class="pagination">
                    </el-pagination>
                </div>
            </el-col>
            
            <el-col :span="6" class="right-column">
                <div class="right-recommendations">
                    <h3 class="recommend-title">猜你想看</h3>
                    <div 
                        v-for="(gourmet, index) in topList" 
                        :key="index" 
                        class="compact-recommend-item">
                        <div class="left">
                            <img :src="gourmet.cover">
                        </div>
                        <div class="right">
                            <div class="user-info">
                                <img :src="gourmet.userAvatar" alt="">
                                <span>{{ gourmet.userName }}</span>
                            </div>
                            <div class="title" @click="readGourmet(gourmet)">{{ gourmet.title }}</div>
                            <div class="meta">
                                <span>{{ timeOut(gourmet.createTime) }}</span>
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
            this.fetchGourmetData();
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
            this.$axios.post('/gourmet/queryList', queryDto).then(res => {
                const { data } = res;
                if (data.code === 200) {
                    this.gourmetList = res.data.data;
                    this.totalItems = data.total;
                }
            }).catch(error => {
                console.log(error);
            });
        },
    }
};
</script>

<style scoped lang="scss">
.gourmet-container {
    background-color: #f8f9fa;
    padding: 30px;
    min-height: calc(100vh - 60px);
    
    .header-section {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        padding-bottom: 15px;
        border-bottom: 1px solid #eaeaea;
        
        .page-title {
            font-size: 24px;
            color: #333;
            font-weight: 600;
            margin: 0;
            letter-spacing: 0.5px;
        }
        
        .search-input {
            width: 280px;
            
            .el-input__inner {
                border-radius: 4px;
                border: 1px solid #dcdfe6;
            }
            
            .el-input-group__append {
                background-color: #4a6fa5;
                border-color: #4a6fa5;
                color: white;
                
                &:hover {
                    background-color: #3a5a80;
                }
            }
        }
    }
    
    .category-section {
        margin-bottom: 20px;
        
        .category-tag {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 16px;
            margin-right: 8px;
            font-size: 13px;
            cursor: pointer;
            transition: all 0.3s ease;
            background-color: #f1f3f5;
            color: #495057;
            margin-bottom: 8px;
            
            &:hover {
                background-color: #e9ecef;
            }
            
            &.active {
                background-color: #0f753f;
                color: white;
            }
        }
    }
    
    .empty-state {
        background: white;
        padding: 40px 0;
        border-radius: 8px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    }
    
    .compact-gourmet-item {
        display: flex;
        margin-bottom: 15px;
        padding: 12px;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        transition: all 0.2s ease;
        
        &:hover {
            transform: translateY(-2px);
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        }
        
        .left {
            flex-shrink: 0;
            
            img {
                width: 120px;
                height: 90px;
                border-radius: 4px;
                object-fit: cover;
            }
        }
        
        .right {
            flex: 1;
            padding-left: 12px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            
            .user-info {
                display: flex;
                align-items: center;
                margin-bottom: 6px;
                
                img {
                    width: 18px;
                    height: 18px;
                    border-radius: 50%;
                    margin-right: 6px;
                }
                
                span {
                    font-size: 12px;
                    color: #666;
                }
            }
            
            .title {
                font-size: 16px;
                font-weight: 600;
                margin-bottom: 6px;
                color: #333;
                cursor: pointer;
                line-height: 1.3;
                
                &:hover {
                    color: #4a6fa5;
                }
            }
            
            .excerpt {
                font-size: 13px;
                color: #666;
                margin-bottom: 8px;
                line-height: 1.4;
                display: -webkit-box;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }
            
            .meta {
                display: flex;
                font-size: 11px;
                color: #999;
                
                span {
                    margin-right: 12px;
                    display: flex;
                    align-items: center;
                    
                    i {
                        margin-right: 3px;
                        font-size: 12px;
                    }
                }
            }
        }
    }
    
    .pagination {
        margin-top: 20px;
        padding: 15px 0;
        background: white;
        border-radius: 8px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        display: flex;
        justify-content: center;
    }
    
    .right-column {
        padding-left: 15px !important;
    }
    
    .right-recommendations {
        padding: 15px;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        position: sticky;
        top: 80px;
        
        .recommend-title {
            font-size: 16px;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
            color: #333;
            font-weight: 600;
        }
    
        .compact-recommend-item {
            display: flex;
            margin-bottom: 12px;
            padding-bottom: 12px;
            border-bottom: 1px dashed #eee;
            
            &:last-child {
                border-bottom: none;
                margin-bottom: 0;
                padding-bottom: 0;
            }
            
            .left {
                flex-shrink: 0;
                
                img {
                    width: 80px;
                    height: 60px;
                    border-radius: 4px;
                    object-fit: cover;
                }
            }
            
            .right {
                flex: 1;
                padding-left: 10px;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                
                .user-info {
                    display: flex;
                    align-items: center;
                    margin-bottom: 4px;
                    
                    img {
                        width: 16px;
                        height: 16px;
                        border-radius: 50%;
                        margin-right: 5px;
                    }
                    
                    span {
                        font-size: 11px;
                        color: #666;
                    }
                }
                
                .title {
                    font-size: 14px;
                    font-weight: 500;
                    margin-bottom: 5px;
                    line-height: 1.3;
                    cursor: pointer;
                    display: -webkit-box;

                    -webkit-box-orient: vertical;
                    overflow: hidden;
                    
                    &:hover {
                        color: #4a6fa5;
                    }
                }
                
                .meta {
                    font-size: 11px;
                    color: #999;
                    display: flex;
                    
                    span {
                        margin-right: 10px;
                        display: flex;
                        align-items: center;
                        
                        i {
                            margin-right: 3px;
                            font-size: 12px;
                        }
                    }
                }
            }
        }
    }
}
</style>