<template>
  <div class="logo-container">
    <div class="logo-wrapper">
      <img src="/LOGO0.png" alt="健康图标" class="logo-icon" />
      <div class="logo-text">
        <span class="brand-text">{{ sysName }}</span>
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
      default: "蝶启新生"
    }
  }
};
</script>

<style scoped>
.logo-container {
  display: flex;
  align-items: center;
  padding: 5px 0;
  justify-content: flex-start;
  width: auto;
  max-width: 180px;
}

.logo-wrapper {
  display: flex;
  align-items: center;
  gap: 8px;
  justify-content: flex-start;
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
  font-size: 24px;
  font-family: '行楷', '华文行楷', 'STXingkai', '行书', '楷体', serif;
  font-weight: 600;
  color: #3498db;
  text-shadow: 
    0 0 6px rgba(52, 152, 219, 0.5),
    0 0 10px rgba(52, 152, 219, 0.3);
  -webkit-text-stroke: 0.1px rgba(255, 255, 255, 0.7);
  background-image: 
    linear-gradient(to right, #2980b9, #3498db, #5dade2, #3498db, #2980b9);
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
  background: linear-gradient(90deg, transparent, rgba(52, 152, 219, 0.4), rgba(52, 152, 219, 0.7), rgba(52, 152, 219, 0.4), transparent);
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