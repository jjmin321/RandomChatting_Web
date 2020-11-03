<template>
  <div class="signup-modal">
        <div class="signup-modal-area" @click="onClose"/>
        <div class="signup-modal-box">
            <h3 class="signup-modal-box-title">회원가입</h3>
            <div class="signup-modal-box-form">
                <span>아이디</span>
                <input v-model="id" type="text" placeholder="4~15자 이내로 입력해주세요." autofocus />
            </div>
            <div class="signup-modal-box-form">
                <span>비밀번호</span>
                <input v-model="pw" type="password" placeholder="6~15자 이내로 입력해주세요." />
            </div>
            <div class="signup-modal-box-form">
                <span>닉네임</span>
                <input v-model="name" type="text" placeholder="2~15자 이내로 입력해주세요." />
            </div>
                <button class="signup-modal-box-submit" @click="signup">회원가입</button>                
        </div>
  </div>
</template>

<script>
import axios from 'axios'
import swal from 'sweetalert2';

export default {
    name: "signup-modal",
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
        signup: function(id, pw, name) {
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
.signup-modal {
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
        padding: 2rem;
        width: 30rem;
        height: 25rem;
        &-title {
            font-size: 1.3rem;
        }
        &-form {
            display: flex;
            flex-direction: column;
            margin-bottom: 5px;
            input {
                margin-top: 5px;
                border-radius: 5px;
                padding: 0.5rem;
                border: 1px solid gray;
                &:focus {
                    outline: none;
                }
            }
        }
        &-submit {
          width: 90px;
          height: 40px;
          background-color: #36bc9b;
          color: white;
          margin-top: 1.5em;
          border: none;
          transition: all .3s ease;
          cursor: pointer;
          font-size: 14px;
          font-weight: bold;
          display : flex;
          justify-content: center;
          align-items:center;
          align-self: center;
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