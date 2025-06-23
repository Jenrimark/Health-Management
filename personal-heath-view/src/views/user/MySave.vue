<template>
    <div class="my-save-container">
        <div v-if="collectionList.length === 0" class="empty-state">
            <el-empty description="暂无收藏内容"></el-empty>
            <el-button type="primary" size="small" @click="$router.push('/gourmet')">去论坛看看</el-button>
        </div>
        <div v-else class="collection-content">
            <div class="collection-header">
                <h3><i class="el-icon-star-on"></i> 我的收藏 <span class="count-badge">{{ collectionList.length }}</span></h3>
            </div>
            <div class="collection-list">
                <div class="collection-item" v-for="(gourmet, index) in collectionList" :key="index">
                    <div class="item-cover">
                        <img :src="gourmet.cover" :alt="gourmet.title">
                        <div class="cover-overlay">
                            <i class="el-icon-view"></i>
                        </div>
                    </div>
                    <div class="item-content">
                        <div class="user-info">
                            <img :src="gourmet.userAvatar" :alt="gourmet.userName">
                            <span>{{ gourmet.userName }}</span>
                            <el-tag size="mini" type="info" class="post-date">{{ formatTime(gourmet.createTime) }}</el-tag>
                        </div>
                        <h4 class="item-title" @click="readGourmet(gourmet)">{{ gourmet.title }}</h4>
                        <div class="item-excerpt">{{ trimText(gourmet.detail, 100) }}</div>
                        <div class="item-meta">
                            <div class="meta-stats">
                                <span class="meta-item upvote"><i class="el-icon-thumb"></i>{{ gourmet.upvoteCount }}</span>
                                <span class="meta-item view"><i class="el-icon-view"></i>{{ gourmet.viewCount }}</span>
                                <span class="meta-item save"><i class="el-icon-star-on"></i>{{ gourmet.saveCount }}</span>
                            </div>
                            <div class="action-buttons">
                                <el-button size="mini" type="primary" round class="read-btn" @click="readGourmet(gourmet)">
                                    阅读全文 <i class="el-icon-right"></i>
                                </el-button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { timeAgo } from "@/utils/data"

export default {
    name: "MySave",
    data() {
        return {
            collectionList: [],
        }
    },
    created() {
        this.fetchCollectionData();
    },
    methods: {
        trimText(text, maxLength) {
            if (!text) return '';
            return text.length > maxLength ? text.substring(0, maxLength) + '...' : text;
        },
        formatTime(time) {
            return timeAgo(time);
        },
        readGourmet(gourmet) {
            sessionStorage.setItem('gourmetId', gourmet.id);
            this.$router.push('/gourmetDetail');
        },
        handleFilterClear() {
            this.filterText = '';
            this.fetchCollectionData();
        },
        // 查询我自己收藏的内容
        fetchCollectionData() {
            this.$axios.post('/interaction/queryCollectionList', {}).then(res => {
                const { data } = res;
                if (data.code === 200) {
                    this.collectionList = res.data.data;
                }
            }).catch(error => {
                console.log(error);
            });
        },
    }
};
</script>

<style scoped lang="scss">
.my-save-container {
    padding: 10px 0;
}

.empty-state {
    padding: 40px 0;
    text-align: center;
    
    .el-button {
        margin-top: 15px;
        background-color: #0f753f;
        border-color: #0f753f;
        
        &:hover {
            background-color: #0b5e32;
            border-color: #0b5e32;
        }
    }
}

.collection-content {
    margin-bottom: 20px;
}

.collection-header {
    margin-bottom: 20px;
    border-bottom: 1px solid #eaeaea;
    padding-bottom: 15px;
    
    h3 {
        font-size: 20px;
        font-weight: 600;
        color: #1f2937;
        margin: 0;
        display: flex;
        align-items: center;
        
        i {
            color: #f59e0b;
            margin-right: 8px;
            font-size: 22px;
        }
        
        .count-badge {
            background-color: #0f753f;
            color: white;
            font-size: 14px;
            padding: 2px 8px;
            border-radius: 12px;
            margin-left: 10px;
            font-weight: 500;
        }
    }
}

.collection-list {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.collection-item {
    display: flex;
    margin-bottom: 20px;
    padding: 16px;
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
    transition: all 0.3s ease;
    border: 1px solid #f0f0f0;
    
    &:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 16px rgba(0,0,0,0.1);
        
        .cover-overlay {
            opacity: 1;
        }
        
        .item-title {
            color: #0f753f;
        }
    }
}

.item-cover {
    flex-shrink: 0;
    width: 180px;
    height: 130px;
    position: relative;
    overflow: hidden;
    border-radius: 8px;
    
    img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.5s ease;
    }
    
    .cover-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.4);
        display: flex;
        align-items: center;
        justify-content: center;
        opacity: 0;
        transition: all 0.3s ease;
        
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

.item-content {
    flex: 1;
    padding-left: 20px;
    display: flex;
    flex-direction: column;
}

.user-info {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
    
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
        margin-right: 10px;
    }
    
    .post-date {
        background-color: #f3f4f6;
        color: #6b7280;
        border: none;
    }
}

.item-title {
    font-size: 18px;
    font-weight: 700;
    margin-bottom: 10px;
    line-height: 1.4;
    color: #1f2937;
    cursor: pointer;
    transition: color 0.3s ease;
    
    &:hover {
        color: #0f753f;
    }
}

.item-excerpt {
    font-size: 14px;
    color: #6b7280;
    line-height: 1.5;
    margin-bottom: 16px;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.item-meta {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: auto;
    
    .meta-stats {
        display: flex;
        
        .meta-item {
            display: flex;
            align-items: center;
            margin-right: 16px;
            font-size: 13px;
            color: #6b7280;
            
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
    }
    
    .action-buttons {
        .el-button {
            margin-left: 8px;
            
            &.el-button--primary {
                background-color: #0f753f;
                border-color: #0f753f;
                
                &:hover {
                    background-color: #0b5e32;
                    border-color: #0b5e32;
                }
            }
        }
    }
    
    .read-btn {
        background-color: #0f753f;
        border-color: #0f753f;
        color: white;
        transition: all 0.3s ease;
        
        &:hover {
            background-color: #0b5e32;
            border-color: #0b5e32;
            transform: translateX(3px);
        }
    }
}
</style>
