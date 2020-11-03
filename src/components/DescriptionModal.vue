<template>
  <div class="description-modal">
        <div class="description-modal-area" @click="onClose"/>
        <div class="description-modal-box">
            <h3 class="description-modal-box-title">대소고 랜덤채팅</h3>
            <ol>
                <li class="description-modal-box-description">대구소프트웨어고등학교 학생들이 함께 사용할 수 있는 채팅 서비스입니다</li>
                <li class="description-modal-box-description">익명성을 악용하여 타인에게 상처를 입히는 채팅은 자제해주시길 바랍니다</li>
                <li class="description-modal-box-description">전체 채팅은 모두가 함께 사용하는 채팅방이며, 랜덤 채팅은 사람이 랜덤으로 매칭됩니다</li>
                <li class="description-modal-box-description">전체 채팅과 랜덤 채팅이 동시에 접속되며, 클릭을 통해 두 채팅방을 이동할 수 있습니다</li>
                <li class="description-modal-box-description">현재 접속되어 있는 유저 목록을 확인할 수 있고, 한 계정으로 다중 접속은 불가능합니다</li>
                <li class="description-modal-box-description">채팅 길이는 100자로 제한되며, 도배 방지를 위해 채팅을 친 후 1초 동안 채팅을 보내지 못합니다</li>
                <li class="description-modal-box-description">자세한 정보와 코드는 깃허브를 참고해 주세요 <a href="https://github.com/jjmin321/randomchatting_web" target="_blank">웹</a>, <a href="https://github.com/jjmin321/randomchatting_server" target="_blank">서버</a></li>
                <li class="description-modal-box-description">버그 발견 및 질문, 요청사항은 <a href="https://www.facebook.com/profile.php?id=100028649371922" target="_blank">페메</a>로 알려주세요</li>
            </ol>
        </div>
  </div>
</template>

<script>
export default {
    name: "description-modal",
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
.description-modal {
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