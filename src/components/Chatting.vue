<template>
  <div>
      <div>
      <input v-model="name">
      <input v-model="pw">
      <button @click="logIn(name, pw)">Log In</button>
      </div>
      <!-- <div>
      <input v-model="message">
      <button @click="sendMessage(message)">Send Message</button>
      </div> -->
  </div>
</template>

<script>
import axios from 'axios'
export default {
    name : 'ChattingVue',
    data: function() {
        return {
            connection: null,
            name: '',
            pw: ''
        }
    },
    methods: {
        logIn: function(name, pw) {
            axios.post("http://localhost:80/signIn", {
                name: this.name,
                pw: this.pw
            })
            .then((Response) => {
                console.log("hi")
            })
            .catch(() => {
                console.log("sibal")
            })
        },
        signIn: function(name, pw) {

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

<style>

</style>