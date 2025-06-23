<template>
  <div class="logo-container">
    <div class="logo-wrapper">
      <img src="/LOGO0.png" alt="健康图标" class="logo-icon" />
      <div class="logo-text">
        <span class="brand-text">爱健康</span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Logo",
  props: {
    sysName: {
      type: String,
      default: "健康管理系统"
    }
  }
};
</script>

<style scoped>
.logo-container {
  display: flex;
  align-items: center;
  padding: 10px 0;
}

.logo-wrapper {
  display: flex;
  align-items: center;
  gap: 10px;
}

.logo-icon {
  width: 36px;
  height: 36px;
  object-fit: contain;
}

.logo-text {
  display: flex;
  flex-direction: column;
}

@font-face {
  font-family: 'FangSong';
  src: local('FangSong'), local('仿宋'), local('STFangsong'), local('华文仿宋');
  font-display: swap;
}

.brand-text {
  font-size: 28px;
  font-family: 'FangSong', '方正行楷简体', '华文行楷', 'STXingkai', '华文楷体', serif;
  font-weight: 600;
  color: #0f753f;
  text-shadow: 
    1px 1px 2px rgba(82, 200, 115, 0.4),
    0px 0px 6px rgba(255, 255, 255, 0.5);
  background-image: 
    linear-gradient(to right, #0f753f, #38b169, #52c873, #38b169, #0f753f);
  background-size: 200% auto;
  background-clip: text;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  letter-spacing: 2px;
  position: relative;
  animation: shimmer 8s ease infinite;
}

.brand-text::after {
  content: "";
  position: absolute;
  bottom: 2px;
  left: 2px;
  width: 90%;
  height: 1px;
  background: linear-gradient(90deg, transparent, rgba(15, 117, 63, 0.4), rgba(82, 200, 115, 0.6), rgba(15, 117, 63, 0.4), transparent);
  filter: blur(1px);
}

@keyframes shimmer {
  0% {
    background-position: 0% center;
  }
  50% {
    background-position: 100% center;
  }
  100% {
    background-position: 0% center;
  }
}
</style>