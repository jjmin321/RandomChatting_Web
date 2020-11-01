<template>
  <div class="web-modal">
        <div class="web-modal-area" @click="onClose"/>
        <div class="web-modal-box">
            <h3 class="web-modal-box-title">대소고 랜덤채팅 웹</h3>
            <ol>
                <li class="web-modal-box-description">대구소프트웨어고등학교 2학년 2학기 프로젝트 실무 시간에 개발하였습니다</li>
                <li class="web-modal-box-description">다른 사람이 기분이 나쁠만한 닉네임이나 채팅을 자제해주세요</li>
                <li class="web-modal-box-description">더 자세한 정보와 코드는 <a href="https://github.com/jjmin321/randomchatting_web" target="_blank">이곳</a>에 있습니다</li>
                <li class="web-modal-box-description">버그 발견 및 요청사항은 <a href="https://www.facebook.com/profile.php?id=100028649371922" target="_blank">페메</a>로 알려주세요</li>
            </ol>
        </div>
  </div>
</template>

<script>
import axios from 'axios'
import swal from 'sweetalert2';

export default {
    name: "web-modal",
    data: () => {
        return {
            id: "",
            pw: "",
            name: ""
        }
    },
    methods: {
        onClose() {
            this.$emit("onClose");
        },
        web: function(id, pw, name) {
            if (this.id.length < 4 || this.id.length > 15) {
                swal.fire({
                    icon: 'warning',
                    title: '아이디를 4~15자 이내로 입력해주세요',
                    timer: 1500
                })
            } else if (this.pw.length < 6 || this.pw.length > 15) {
                swal.fire({
                    icon: 'warning',
                    title: '비밀번호를 6~15자 이내로 입력해주세요',
                    timer: 1500
                })
            } else if (this.name.length < 2 || this.name.length > 15) {
                swal.fire({
                    icon: 'warning',
                    title: '닉네임을 2~15자 이내로 입력해주세요',
                    timer: 1500
                })
            } else {
                axios.post("http://35.202.66.120:8080/signUp", {
                id: this.id,
                pw: this.pw,
                name: this.name
            })
            .then((Response) => {
                swal.fire({
                    icon: 'success', 
                    title: Response.data.message,
                    timer: 1500
                })
                this.onClose()
            })
            .catch((error) => {
                swal.fire({
                    icon: 'warning',
                    title: error.response.data.message,
                    timer: 1500
                })
            })
            }
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