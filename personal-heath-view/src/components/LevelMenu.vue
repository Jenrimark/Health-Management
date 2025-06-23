<template>
    <div class="nav">
        <Logo sysName="蝶启新生" />
        <div v-for="(item, index) in visibleMenus" :key="index" 
            :style="{ color: selectedIndex === index ? '#1c1c1c' : 'rgb(102 102 102)' }"
            class="menu-item" 
            @click="menuClick(`${item.path}`, index)">
            <span>
                <i :class="item.icon"></i>
                <span>&nbsp; {{ item.name }}</span>
            </span>
        </div>

        <div class="messsage">
            <el-badge v-if="noReadMsg !== 0" :value="noReadMsg">
                <span class="message-span" @click="messageCenter">
                    <i class="el-icon-chat-dot-round"></i>
                </span>
            </el-badge>
            <span v-else class="message-span" @click="messageCenter">
                <i class="el-icon-chat-dot-round"></i>
            </span>
        </div>
        <div>
            <el-dropdown class="user-dropdown">
                <span class="el-dropdown-link" style="display: flex; align-items: center;">
                    <el-avatar :size="25" :src="userInfo.url" style="margin-top: 0;"></el-avatar>
                    <span class="userName"
                        style="margin-left: 5px;font-size: 14px;width: 100px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;">{{
                            userInfo.name }}</span>
                    <i class="el-icon-arrow-down el-icon--right" style="margin-left: 5px;"></i>
                </span>
                <el-dropdown-menu slot="dropdown">
                    <el-dropdown-item icon="el-icon-user" @click.native="userCenterPanel">个人中心</el-dropdown-item>
                    <el-dropdown-item icon="el-icon-warning-outline" @click.native="resetPwd">修改密码</el-dropdown-item>
                    <el-dropdown-item icon="el-icon-back" @click.native="loginOut">退出登录</el-dropdown-item>
                </el-dropdown-menu>
            </el-dropdown>
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
                    icon: 'success', // 使用'success'图标表示操作成功
                    showConfirmButton: false, // 隐藏确认按钮，使得弹窗只展示信息后自动关闭
                    timer: 1300, // 自动关闭弹窗的延迟时间，这里是2秒
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
    gap: 30px;
    height: 80px;
    padding: 6px 80px;

    .menu-item {
        font-size: 14px;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .messsage:hover{
        background-color: rgb(40, 150, 103);
    }

    .messsage{
        background-color: rgb(56, 183, 129);
        cursor: pointer;
        padding: 2px 14px;
        border-radius: 10px;
        color: rgb(255,255,255);
    }
}
</style>