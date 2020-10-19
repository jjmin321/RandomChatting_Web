<template>
  <div class="login-modal">
        <div class="login-modal-area" @click="onClose"/>
        <div class="login-modal-box">
            <h3 class="login-modal-box-title">로그인</h3>
            <div class="login-modal-box-form">
                <span>아이디</span>
                <input v-model="id" type="text" placeholder="아이디를 입력해주세요." autofocus />
            </div>
            <div class="login-modal-box-form">
                <span>비밀번호</span>
                <input v-model="pw" type="text" placeholder="비밀번호를 입력해주세요." />
            </div>
                <button class="login-modal-box-submit" @click="login">로그인</button>                
        </div>
  </div>
</template>

<script>
import axios from 'axios'
import swal from 'sweetalert2'
import cookies from 'js-cookie' // https://www.npmjs.com/package/js-cookie

export default {
    name: "login-modal",
    data: () => {
        return {
            id: "",
            pw: ""
        }
    },
    methods: {
        onClose() {
            this.$emit("onClose");
        },
        login: function(id, pw) {
            axios.post("http://localhost:80/signIn", {
                id: this.id,
                pw: this.pw
            })
            .then((Response) => {
                swal.fire({
                    icon: 'success', 
                    title: Response.data.message,
                    timer: 1500
                })
                this.onClose()
                cookies.set('accessToken', Response.data.accessToken, { expires: 7 });
            })
            .catch((error) => { 
                console.log(cookies.get())
                swal.fire({
                    icon: 'warning',
                    title: error.response.data.message,
                    timer: 1500
                })
            })
        },  
        }
    }
</script>

<style lang="scss">
.login-modal {
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
        height: 20rem;
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