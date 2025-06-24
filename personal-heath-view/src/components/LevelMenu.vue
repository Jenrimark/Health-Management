<template>
    <div class="nav">
        <Logo sysName="蝶启新生" />
        <div class="menu-items-container">
            <div v-for="(item, index) in visibleMenus" :key="index" 
                :class="['menu-item', selectedIndex === index ? 'active' : '']" 
                @click="menuClick(`${item.path}`, index)">
                <i :class="item.icon"></i>
                <span>{{ item.name }}</span>
                <div class="indicator" v-if="selectedIndex === index"></div>
            </div>
        </div>

        <div class="right-actions">
            <div class="message-btn" :class="{ 'active-icon': $route.path === '/message' }">
                <el-badge v-if="noReadMsg !== 0" :value="noReadMsg" class="badge">
                    <span class="message-span" @click="messageCenter">
                        <i class="el-icon-chat-dot-round"></i>
                    </span>
                </el-badge>
                <span v-else class="message-span" @click="messageCenter">
                    <i class="el-icon-chat-dot-round"></i>
                </span>
            </div>
            <div class="family-btn" :class="{ 'active-icon': $route.path === '/family-management' }" @click="familyManagement">
                <i class="el-icon-house"></i>
            </div>
            <div class="user-info">
                <el-dropdown class="user-dropdown" trigger="click">
                    <span class="el-dropdown-link">
                        <el-avatar :size="32" :src="userInfo.url" class="user-avatar"></el-avatar>
                        <span class="user-name">{{ userInfo.name }}</span>
                        <i class="el-icon-arrow-down el-icon--right"></i>
                    </span>
                    <el-dropdown-menu slot="dropdown" class="custom-dropdown">
                        <el-dropdown-item icon="el-icon-user" @click.native="userCenterPanel">个人中心</el-dropdown-item>
                        <el-dropdown-item icon="el-icon-warning-outline" @click.native="resetPwd">修改密码</el-dropdown-item>
                        <el-dropdown-item icon="el-icon-house" @click.native="familyManagement">家庭管理</el-dropdown-item>
                        <el-dropdown-item icon="el-icon-back" @click.native="loginOut">退出登录</el-dropdown-item>
                    </el-dropdown-menu>
                </el-dropdown>
            </div>
        </div>
    </div>
</template>

<script>
import { clearToken } from "@/utils/storage.js";
import Logo from '@/components/Logo.vue';
export default {
    name: "UserMenu",
    components: {
        Logo
    },
    data() {
        return {
            selectedIndex: 0,
            messagePath: '/message',
            loginPath: '/login',
            sysName: '蝶启新生',
            defaultPath: '/user-health-model',
            filterText: '',
            noReadMsg: 0,
            gourtmetQueryDto: {},
            currentPage: 1,
            pageSize: 10,
            totalItems: 0,
        }
    },
    props: {
        // 路由菜单数据
        menus: {
            type: Array,
            required: true
        },
        // 用户信息数据
        userInfo: {
            type: Object,
            required: true
        }
    },
    mounted() {
        this.pathToDo(this.defaultPath);
        this.loadMsgCount();
        
        // 根据当前路径设置选中菜单
        const currentPath = this.$route.path;
        const menuIndex = this.visibleMenus.findIndex(item => item.path === currentPath);
        if (menuIndex !== -1) {
            this.selectedIndex = menuIndex;
        }
    },
    computed: {
        visibleMenus() {
            return this.menus.filter(item => !item.isHidden);
        }
    },
    methods: {
        // 搜索关键词，返回父组件处理
        search() {
            // 如果当前是搜索页面了，更新关键词即可
            if (this.$route.path === '/search-detail') {
                sessionStorage.setItem('keyWord', this.filterText);
                return;
            }
            // 将关键词存起来
            sessionStorage.setItem('keyWord', this.filterText);
            this.$emit('eventListener', 'search-detail');
        },
        // 个人中心，传回父组件处理
        userCenterPanel() {
            this.$emit('eventListener', 'center');
        },
        // 重置密码，传回父组件处理
        resetPwd() {
            this.$emit('eventListener', 'resetPwd');
        },
        // 家庭管理，传回父组件处理
        familyManagement() {
            this.$emit('eventListener', 'familyManagement');
        },
        // 退出登录，传回父组件处理
        loginOut() {
            this.$emit('eventListener', 'loginOut');
        },
        // 记录饮食，传回父组件处理
        dietRecord() {
            this.$emit('eventListener', 'dietRecord');
        },
        async loadMsgCount() {
            const userInfo = sessionStorage.getItem('userInfo');
            const userInfoEntity = JSON.parse(userInfo);
            const messageQueryDto = { userId: userInfoEntity.id, isRead: false }
            const response = await this.$axios.post(`/message/query`, messageQueryDto);
            const { data } = response;
            if (data.code === 200) {
                this.noReadMsg = data.data.length;
            }
        },
        // 不是存量路由，则跳转
        pathToDo(path) {
            if (this.$route.path !== path) {
                this.$router.push(path);
            }
        },
        //路由跳转
        menuClick(path, index) {
            this.selectedIndex = index;
            this.pathToDo(path);
        },
        // 消息中心
        messageCenter() {
            this.selectedIndex = null;
            this.pathToDo(this.messagePath);
        },
        // 退出登录
        async out() {
            const confirmed = await this.$swalConfirm({
                title: '是否退出登录',
                text: `退出后将重新登录，才能使用系统功能`,
                icon: 'warning',
            });
            if (confirmed) {
                this.$swal.fire({
                    title: '退出登录',
                    text: '您已成功退出登录。',
                    icon: 'success',
                    showConfirmButton: false,
                    timer: 1300,
                });
                setTimeout(() => {
                    clearToken();
                    this.$router.push('/loginPath');
                }, 1300)
            } else {
                console.log('用户取消了退出操作');
            }
        },
        handleFilterClear() {
            this.filterText = '';
            this.fetchGourmetData();
        },
    }
}
</script>

<style scoped lang="scss">
.nav {
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 70px;
    padding: 0 40px;
    background-color: #ffffff;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    position: relative;

    .menu-items-container {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-left: 20px;
        flex: 1;
        overflow-x: auto;
        padding: 0 10px;
        
        /* 隐藏滚动条但允许滚动 */
        &::-webkit-scrollbar {
            display: none;
        }
        -ms-overflow-style: none;
        scrollbar-width: none;
    }

    .menu-item {
        position: relative;
        padding: 8px 16px;
        border-radius: 6px;
        font-size: 15px;
        color: #606266;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 6px;
        white-space: nowrap;
        
        /* 添加悬停效果 */
        display: inline-block;
        backface-visibility: hidden;
        vertical-align: middle;
        position: relative;
        box-shadow: 0 0 1px rgba(0, 0, 0, 0);
        transform: translateZ(0);
        transition-duration: 0.3s;
        transition-property: transform;
        
        i {
            font-size: 16px;
            margin-right: 2px;
        }
        
        &:hover {
            color: #42b983;
            background-color: #ffffff;
            transform: scale(1.05);
            box-shadow: 0 4px 8px rgba(66, 185, 131, 0.15);
        }
        
        &.active {
            color: #42b983;
            font-weight: 500;
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(66, 185, 131, 0.15);
            
            .indicator {
                position: absolute;
                bottom: -1px;
                left: 50%;
                transform: translateX(-50%);
                width: 16px;
                height: 3px;
                background-color: #42b983;
                border-radius: 4px;
            }
        }
    }
    
    .right-actions {
        display: flex;
        align-items: center;
        gap: 16px;
    }
    
    .message-btn {
        cursor: pointer;
        position: relative;
        
        .message-span {
            cursor: pointer;
            padding: 8px;
            border-radius: 8px;
            background-color: rgba(66, 185, 131, 0.1);
            color: #42b983;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            
            /* 添加悬停效果 */
            backface-visibility: hidden;
            position: relative;
            box-shadow: 0 0 1px rgba(0, 0, 0, 0);
            transform: translateZ(0);
            transition-duration: 0.3s;
            transition-property: transform;
            
            i {
                font-size: 20px;
            }
            
            &:hover {
                background-color: #ffffff;
                transform: scale(1.05);
                box-shadow: 0 4px 8px rgba(66, 185, 131, 0.15);
            }
        }
        
        .badge {
            ::v-deep .el-badge__content {
                background-color: #ff4d4f;
                border: none;
                z-index: 10;
            }
        }
        
        &.active-icon {
            .message-span {
                background-color: #42b983;
                color: white;
                transform: scale(1.05);
                box-shadow: 0 4px 8px rgba(66, 185, 131, 0.3);
            }
        }
    }
    
    .family-btn {
        cursor: pointer;
        padding: 8px;
        border-radius: 8px;
        background-color: rgba(66, 185, 131, 0.1);
        color: #42b983;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s ease;
        
        /* 添加悬停效果 */
        backface-visibility: hidden;
        position: relative;
        box-shadow: 0 0 1px rgba(0, 0, 0, 0);
        transform: translateZ(0);
        transition-duration: 0.3s;
        transition-property: transform;
        
        i {
            font-size: 20px;
        }
        
        &:hover {
            background-color: #ffffff;
            transform: scale(1.05);
            box-shadow: 0 4px 8px rgba(66, 185, 131, 0.15);
        }
        
        &.active-icon {
            background-color: #42b983;
            color: white;
            transform: scale(1.05);
            box-shadow: 0 4px 8px rgba(66, 185, 131, 0.3);
        }
    }
    
    .user-info {
        .user-dropdown {
            cursor: pointer;
            
            .el-dropdown-link {
                display: flex;
                align-items: center;
                gap: 8px;
                padding: 5px 10px;
                border-radius: 8px;
                transition: all 0.3s ease;
                
                /* 添加悬停效果 */
                backface-visibility: hidden;
                position: relative;
                box-shadow: 0 0 1px rgba(0, 0, 0, 0);
                transform: translateZ(0);
                transition-duration: 0.3s;
                transition-property: transform;
                
                &:hover {
                    background-color: #ffffff;
                    transform: scale(1.02);
                    box-shadow: 0 4px 8px rgba(66, 185, 131, 0.15);
                }
                
                .user-avatar {
                    border: 2px solid rgba(66, 185, 131, 0.2);
                    transition: all 0.3s ease;
                    
                    &:hover {
                        transform: scale(1.05);
                    }
                }
                
                .user-name {
                    font-size: 14px;
                    color: #333;
                    max-width: 100px;
                    overflow: hidden;
                    text-overflow: ellipsis;
                    white-space: nowrap;
                }
                
                i {
                    color: #909399;
                    transition: all 0.3s ease;
                }
                
                &:hover i {
                    transform: rotate(180deg);
                    color: #42b983;
                }
            }
        }
    }
}

::v-deep .custom-dropdown {
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    
    .el-dropdown-menu__item {
        padding: 10px 20px;
        
        /* 添加悬停效果 */
        backface-visibility: hidden;
        position: relative;
        transform: translateZ(0);
        transition-duration: 0.3s;
        transition-property: transform;
        
        &:hover {
            background-color: #ffffff;
            color: #42b983;
            transform: scale(1.02);
            box-shadow: 0 2px 4px rgba(66, 185, 131, 0.1);
        }
        
        i {
            margin-right: 8px;
        }
    }
}

.family-relation-info {
    padding: 8px;
    background-color: #fff8e1;
    color: #795548;
    text-align: center;
    font-size: 13px;
    border-bottom: 1px solid #ffe0b2;
}
</style>