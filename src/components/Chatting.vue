<template>
  <div>
      <header class="header">
      <div class="header-container">
        <div class="header-profile">
          <!-- <div class="header-profile-image"></div> -->
          <span class="header-profile-name" >{{$store.state.userName}} 님, 안녕하세요</span>
        </div>
        <button class="header-right-btn" @click="logout">로그아웃</button>
      </div>
    </header>
      <!-- <div>
      <input v-model="message">
      <button @click="sendMessage(message)">Send Message</button>
      </div> -->
  </div>
</template>

<script>
import axios from 'axios'
import cookies from 'js-cookie'
export default {
    name : 'ChattingVue',
    data: function() {
        return {
            connection: null,
            name: '',
            pw: ''
        }
    },
    beforeCreate() {
      if (!cookies.get('accessToken')) {
        location.href= '/'     
      }
    },
    methods: {
        logout() {
            cookies.remove('accessToken')
            location.href = '/'
        }
        // sendMessage: function(message) {
        //     this.connection.send("2|"+message);
        // }
    },
    // created: function() {
    //     console.log("Starting Connection to WebSocket Server")
    //     this.connection = new WebSocket("ws://10.80.162.43")

    //     this.connection.onmessage = function(event) {
    //         console.log(event.data);
    //     }

    //     this.connection.onopen = function(event) {
    //         console.log(event)
    //         console.log("Succesfully connected to the websocket server.")
    //     }
    // }
}
</script>

<style lang="scss">
.overflow-hidden {
  overflow: hidden;
}
</style>