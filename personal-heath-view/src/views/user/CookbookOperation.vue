<template>
    <div class="cookbook-operation">
        <!-- 添加头部标签 -->
        <div class="page-header">
          <h2 class="page-title">食谱营养素</h2>
          <p class="page-subtitle">管理您的食谱与营养素数据，科学安排膳食搭配</p>
        </div>
        
        <el-tabs type="border-card">
            <el-tab-pane label="我的食谱">
                <MyCookbook />
            </el-tab-pane>
            <el-tab-pane label="我的营养素">
                <MyNutrimentManage />
            </el-tab-pane>
            <el-tab-pane label="食谱配置">
                <MyCookbookNutrimentManage/>
            </el-tab-pane>
            <el-tab-pane label="精选食谱">
                <PublicCookbook />
            </el-tab-pane>
            <el-tab-pane label="精选营养素">
                <PublicNutriment />
            </el-tab-pane>
        </el-tabs>
    </div>
</template>
<script>
import MyCookbook from "@/views/user/MyCookbook"
import MyNutrimentManage from "@/views/user/MyNutrimentManage"
import MyCookbookNutrimentManage from "@/views/user/MyCookbookNutrimentManage"
import PublicCookbook from "@/views/user/PublicCookbook"
import PublicNutriment from "@/views/user/PublicNutriment"

export default {
    components: { MyCookbook, MyNutrimentManage, MyCookbookNutrimentManage, PublicCookbook, PublicNutriment },
    name: "CookbookOperation",
    data() {
        return {

        }
    },
    created() {

    },
    methods: {

    }
};
</script>
<style scoped lang="scss">
.cookbook-operation {
    padding: 20px;
}

/* 添加页面头部样式 */
.page-header {
  background: linear-gradient(135deg, #42b983, #2c9e6a);
  color: white;
  border-radius: 12px;
  padding: 25px 30px;
  margin-bottom: 30px;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
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

/* 整体容器样式 */
:deep(.el-tabs--border-card) {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  border-radius: 12px;
  border: none;
}
</style>
