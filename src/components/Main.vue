<template>
  <div>
    <header class="header">
        <div class="header-container">
        <button v-if="isLogin == false" class="header-left-btn" @click="loginModalOpen">로그인</button>
        <div v-else class="header-profile">
          <span class="header-profile-name" >{{userName}} 님, 안녕하세요</span>
          <button class="header-left-btn" @click="editnameModalOpen">닉네임 변경</button>
        </div>
        <button v-if="isLogin == false" class="header-right-btn" @click="signupModalOpen">회원가입</button>
        <button v-else class="header-right-btn" @click="logout">로그아웃</button>
        <div @click="descriptionModalOpen" class="header-description" >?</div>
      </div>
    </header>
    <div class="first">
      <img class="background-img" src="../static/background.svg" />
      <div class="first-box">
        <div class="first-content">
          당신의 일상에 위로가 되기를 
          <h1> 대소고 랜덤채팅 </h1>
          <button class="start-btn" onclick="location.href='chatting'">
          시작하기
          </button>
        </div>
      </div>
    </div>
    <description-modal v-if="descriptionModal" @onClose="descriptionModalClose" />
    <login-modal v-if="loginModal" @onClose="loginModalClose" />
    <signup-modal v-if="signupModal" @onClose="signupModalClose" />
    <editname-modal v-if="editnameModal" @onClose="editnameModalClose" />
  </div>
</template>

<script>
import axios from 'axios'
import DescriptionModal from "@/components/DescriptionModal"
import LoginModal from "@/components/LoginModal"
import SignupModal from "@/components/SignupModal"
import EditnameModal from "@/components/EditnameModal"
import cookies from 'js-cookie'
import swal from 'sweetalert2'

export default {
    name : "MainVue",
    data: function(){
        return {
          descriptionModal: false,
          loginModal: false,
          signupModal: false,
          editnameModal: false,
          isLogin: false,
          userName: "",
        }
    },
    components: {
      DescriptionModal,
      LoginModal,
      SignupModal,
      EditnameModal
    },
    beforeCreate() {
      if (cookies.get('accessToken')) {
          axios.get(
            'http://34.64.214.238:8080/getInfo',
            {
              headers: {
                'Authorization': `Bearer ${cookies.get('accessToken')}`
              }
            }
          )
          .then((Response) => {
            this.isLogin = true
            this.userName = Response.data.Member.name
          })
      }
    },
    methods: {
      descriptionModalOpen() {
        this.descriptionModal = true;
      },
      descriptionModalClose() {
        this.descriptionModal = false;
      },
      loginModalOpen() {
        this.loginModal = true;
      },
      loginModalClose() {
        this.loginModal = false;
        if (cookies.get()) {
          location.reload();
        }
      },
      signupModalOpen() {
        this.signupModal = true;
      },
      signupModalClose() {
        this.signupModal = false;
      },
      editnameModalOpen() {
        this.editnameModal = true;
      },
      editnameModalClose() {
        this.editnameModal = false;
        location.reload()
      },
      logout() {
        cookies.remove('accessToken')
        location.reload();
      }
    }
}
</script>

<style lang="scss">
  
  .header {
    display: flex;
    justify-content: center;
    border-bottom: 1px solid gray;
    width: 100%;
    &-container {
      display: flex;
      width: 100%;
      padding: 1.5rem 3rem;
      justify-content: flex-end;
      align-items: center;
    }
  }

  .first {
    display: flex;
    width: 100%;
    min-height: 100vh;
    align-items:center ;
    justify-content: center;
    overflow-y: hidden;
  }
  .first-box {
    display: flex;
    max-width: 1600px;
    width: 100%;
    padding: 0 2rem;
    padding-bottom: 15rem;
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
  .header-left-btn {
    width: 100px;
    height: 40px;
    background-color: #7600FF;
    color: white;
    margin-right: 10px;
    border: none;
    transition: all .3s ease;
    cursor: pointer;
    font-size: 11px;
    font-weight: bold;
    display : flex;
    justify-content: center;
    align-items:center;
    align-self: center;
    animation: image-move 3s 0s;
    box-shadow: 0px 3px 10px rgba(154, 66, 255, 0.9);
    outline: none;
  }
  .header-right-btn {
    width: 100px;
    height: 40px;
    background-color: #7600FF;
    margin-right: 10px;
    color: white;
    padding: 1.5em 2em;
    border: none;
    transition: all .3s ease;
    cursor: pointer;
    font-size: 11px;
    font-weight: bold;
    display : flex;
    justify-content: center;
    align-items:center;
    align-self: center;
    animation: image-move 3s 0s;
    box-shadow: 0px 3px 10px rgba(154, 66, 255, 0.9);
    outline: none;
  }

.header-description {
  width: 2rem;
  height: 2rem;
  border-radius: 50%;
  background-color: skyblue;
  display: flex;
  justify-content: center;
  align-items: center;
  color: #ffffff;
  font-weight: 700;
  font-size: 1rem;
  cursor: pointer;
  margin-left: 1rem;
}

.header-profile {
  display: flex;
  align-items: center;
}

.header-profile-name {
  margin-right: 10px;
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
    border-radius: 5px;
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