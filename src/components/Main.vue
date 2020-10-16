<template>
  <div>
    <header class="header">
      <div class="header-container">
        <button class="login-btn" @click="loginModalOpen">로그인</button>
        <button class="signup-btn" @click="signupModalOpen">회원가입</button>
      </div>
    </header>
    <div class="first">
      <img class="background-img" src="../static/background.svg" />
      <div class="first-box">
        <div class="first-content">
          심심한 새끼들을 위한 거
          <h1> 대소고 랜덤채팅 </h1>
          <button class="start-btn" onclick="location.href='chatting'">
          시작하기
          </button>
        </div>
      </div>
    </div>
    <login-modal v-if="loginModal" @onClose="loginModalClose" />
    <signup-modal v-if="signupModal" @onClose="signupModalClose" />
  </div>
</template>

<script>
import LoginModal from "@/components/LoginModal";
import SignupModal from "@/components/SignupModal";

export default {
    name : "MainVue",
    data: function(){
        return {
          loginModal: false,
          signupModal: false
        }
    },
    components: {
      LoginModal,
      SignupModal
    },
    methods: {
      loginModalOpen() {
        this.loginModal = true;
      },
      loginModalClose() {
        this.loginModal = false;
      },
      signupModalOpen() {
        this.signupModal = true;
      },
      signupModalClose() {
        this.signupModal = false;
      }
    }
}
</script>

<style lang="scss">
  
  .header {
    display: flex;
    justify-content: center;
    border-bottom: 1px solid gray;
    &-container {
      display: flex;
      width: 100%;
      max-width: 1100px;
      padding: 1.5rem 1rem;
      justify-content: flex-end;
    }
  }

  .first {
    display: flex;
    width: 100%;
    min-height: 100vh;
    align-items: center;
    justify-content: center;
    overflow-y: hidden;
  }
  .first-box {
    display: flex;
    max-width: 1600px;
    width: 100%;
    padding: 0 2rem;
    padding-top: 5rem;
    justify-content: space-between;
  }
  
  .first-content {
    display: flex;
    flex-direction: column;
    text-align: center;
    font-size: 2rem;
    flex-grow: 1;
    animation: image-move 2.5s 0s;
    z-index: 0;
  }
  .background-img {
    width: 100%;
    position:absolute;
    bottom: 0;
    left: 0;
    z-index: -1;
    animation: image-move 5s 0s;
  }
  .login-btn {
    width: 100px;
    height: 40px;
     background-color: #7600FF;
    color: white;
    padding: 1.5em 2em;
    border: none;
    transition: all .3s ease;
    cursor: pointer;
    font-size: 11px;
    font-weight: bold;
    display : flex;
    justify-content: center;
    align-items:center;;
    align-self: center;
    animation: image-move 3s 0s;
    box-shadow: 0px 3px 10px rgba(154, 66, 255, 0.9);
  }
  .signup-btn {
    width: 100px;
    height: 40px;
    background-color: #7600FF;
    margin-left: 10px;
    color: white;
    padding: 1.5em 2em;
    border: none;
    transition: all .3s ease;
    cursor: pointer;
    font-size: 11px;
    font-weight: bold;
    display : flex;
    justify-content: center;
    align-items:center;;
    align-self: center;
    animation: image-move 3s 0s;
    box-shadow: 0px 3px 10px rgba(154, 66, 255, 0.9);
  }
  .start-btn {
     width: 160px;
     height: 50px;
    background-color: #7600FF;
    color: white;
    padding: 1.5em 3em;
    border: none;
    transition: all .3s ease;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    display : flex;
    justify-content: center;
    align-items:center;
    align-self: center;
    box-shadow: 0px 3px 10px  rgba(154, 66, 255, 0.9);
  }
  @keyframes image-move {
    0% {
      opacity: 0;
    }
    100% {
      opacity: 1;
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
    background-color:lightskyblue;
  }
  @media screen and (max-width: 1200px) {
    .first-content {
      font-size: 1.2rem !important;
    }
  }
  @media screen and (max-width: 768px) {
    .first-img {
      padding-top: 5rem;
      width: 100%;
    }
    .first-img img {
      width: 100%;
    }
    .first-box {
      flex-direction: column;
      padding-top: 0;
    }
    .first-content {
      font-size: 1rem !important;
    }
  }
</style>