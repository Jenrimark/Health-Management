<template>
  <div class="logo-container">
    <div class="logo-wrapper hoverable">
      <img src="/LOGO0.png" alt="健康图标" class="logo-icon" />
      <div class="logo-text">
        <img src="/logoz2.png" alt="蝶启新生" class="brand-image" />
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
  padding: 5px 10px;
  border-radius: 8px;
  backface-visibility: hidden;
  vertical-align: middle;
  position: relative;
  box-shadow: 0 0 1px rgba(0, 0, 0, 0);
  transform: translateZ(0);
  transition-duration: 0.3s;
  transition-property: transform;
}

.logo-wrapper:hover {
  transform: scale(1.05);
  box-shadow: 0 4px 8px rgba(66, 185, 131, 0.15);
}

.logo-icon {
  width: 36px;
  height: 36px;
  object-fit: contain;
  display: flex;
  align-self: center;
  border-radius: 10px;
}

.logo-text {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-self: center;
  margin-left: -10px;
}

.brand-image {
  height: 50px;
  object-fit: contain;
  display: block;
  margin: 0;
  padding: 0;
  border-radius: 8px;
}

@font-face {
  font-family: 'FangSong';
  src: local('FangSong'), local('仿宋'), local('STFangsong'), local('华文仿宋');
  font-display: swap;
}

.brand-text {
  font-size: 22px;
  font-family: '行楷', '华文行楷', 'STXingkai', '行书', '楷体', serif;
  font-weight: 600;
  line-height: 1.2;
  color: #42b983;
  text-shadow: 
    0 0 6px rgba(66, 185, 131, 0.5),
    0 0 10px rgba(66, 185, 131, 0.3);
  -webkit-text-stroke: 0.1px rgba(255, 255, 255, 0.7);
  background-image: 
    linear-gradient(to right, #2c9e6a, #42b983, #5dd4a4, #42b983, #2c9e6a);
  background-size: 200% auto;
  background-clip: text;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  letter-spacing: 2px;
  position: relative;
  animation: shimmer 8s ease infinite;
  display: block;
  margin: 0;
  padding: 0;
}

.brand-text::after {
  content: "";
  position: absolute;
  bottom: 2px;
  left: 2px;
  width: 90%;
  height: 1px;
  background: linear-gradient(90deg, transparent, rgba(66, 185, 131, 0.4), rgba(66, 185, 131, 0.7), rgba(66, 185, 131, 0.4), transparent);
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

.hoverable {
  cursor: pointer;
  backface-visibility: hidden;
  vertical-align: middle;
  position: relative;
  box-shadow: 0 0 1px rgba(0, 0, 0, 0);
  transform: translateZ(0);
  transition-duration: 0.3s;
  transition-property: transform;
}
</style>