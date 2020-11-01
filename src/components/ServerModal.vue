<template>
  <div class="server-modal">
        <div class="server-modal-area" @click="onClose"/>
        <div class="server-modal-box">
            <h3 class="server-modal-box-title">대소고 랜덤채팅 서버</h3>
            <ol>
                <li class="server-modal-box-description">대구소프트웨어고등학교 2학년 2학기 프로젝트 실무 시간에 개발하였습니다</li>
                <li class="server-modal-box-description">API서버와 웹 소켓 서버를 따로 분리하지 않았습니다</li>
                <li class="server-modal-box-description">랜덤채팅을 만들 때 링크드리스트를 사용하였습니다</li>
                <li class="server-modal-box-description">더 자세한 정보와 코드는 <a href="https://github.com/jjmin321/randomchatting_server" target="_blank">이곳</a>에 있습니다</li>
            </ol>
        </div>
  </div>
</template>

<script>
export default {
    name: "server-modal",
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
.server-modal {
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