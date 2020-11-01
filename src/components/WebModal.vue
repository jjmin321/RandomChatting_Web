<template>
  <div class="web-modal">
        <div class="web-modal-area" @click="onClose"/>
        <div class="web-modal-box">
            <h3 class="web-modal-box-title">대소고 랜덤채팅 웹</h3>
            <ol>
                <li class="web-modal-box-description">대구소프트웨어고등학교 2학년 2학기 프로젝트 실무 시간에 개발하였습니다</li>
                <li class="web-modal-box-description">다른 사람이 기분이 나쁠만한 닉네임이나 채팅을 자제해주세요</li>
                <li class="web-modal-box-description">윈도우 환경에서 자동으로 스크롤이 안 내려가는 부분과 전체 채팅에서 사람 목록이 가끔 이상해지는 버그를 수정 중입니다</li>
                <li class="web-modal-box-description">더 자세한 정보와 코드는 <a href="https://github.com/jjmin321/randomchatting_web" target="_blank">이곳</a>에 있습니다</li>
                <li class="web-modal-box-description">버그 발견 및 요청사항은 <a href="https://www.facebook.com/profile.php?id=100028649371922" target="_blank">페메</a>로 알려주세요</li>
            </ol>
        </div>
  </div>
</template>

<script>
export default {
    name: "web-modal",
    data: () => {
        return {
        }
    },
    methods: {
        onClose() {
            this.$emit("onClose");
        }
    }
}
</script>

<style lang="scss">
.web-modal {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    &-area {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        width: 100%;
        height: 100%;
        z-index: 15;
        background-color: rgba(117, 117, 117, 0.247);
    }
    &-box {
        z-index: 16;
        background-color: white;
        padding: 3rem;
        width: 40rem;
        height: 30rem;
        &-title {
            font-size: 1rem;
            color:seagreen;
        }
        &-description {
            font-size: 0.8rem;
            padding-top: 1.5rem;
            color: gray;
        }
    }
}

button{
    border-top-left-radius: 5px; 
    border-bottom-left-radius: 5px;
    border-top-right-radius: 5px;
    border-bottom-right-radius: 5px;
    background-color: lightblue;
  }
  
  button:hover{
    background-color:purple;
  }
</style>