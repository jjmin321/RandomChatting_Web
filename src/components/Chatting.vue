<template>
  <div>
      <header class="header">
      <div class="header-container">
        <div class="header-profile">
          <!-- <div class="header-profile-image"></div> -->
          <span class="header-profile-name" >{{userName}} 님, 안녕하세요</span>
        </div>
        <button class="header-right-btn" @click="logout">로그아웃</button>
      </div>
    </header>

    <div class="contentWrap">
    <div class="contentCover">
        <div class="roomWrap">
            <div class="roomList">
                <div class="roomHeader">채팅 방 목록</div>
                <div class="roomSelect">
                    <div @click="selectAll" class="roomEl" :class="{ active: selectedRoom === 'All' }" data-class="1">전체 채팅</div>
                    <div @click="selectRoom" class="roomEl" :class="{ active: selectedRoom === 'Room' }" data-class="2">{{roomNum}}번째 방</div>
                </div>
            </div>
        </div>
        <div class="chatWrap" v-if="isJoined == true">
            <div class="chatHeader" v-if="selectedRoom === 'All'">전체 채팅</div>
            <div class="chatHeader" v-else>{{roomNum}}번째 방</div>
            <div class="chatLog">
                <div class="myMsg" v-bind:key="item" v-for = "item in chatLog">
                    <span class="msg" v-if="item.user == '나' ">{{item.message}}</span>
                </div>
                <div class="anotherMsg" v-bind:key="item" v-for = "item in chatLog">
                    <span class="msg" v-if="item.user != '나'">{{item.message}}</span>
                </div>
                <!-- <div class="anotherMsg">
                    <span class="anotherName">Jo</span>
                    <span class="msg">Hello, Nice to meet you.</span>
                </div>
                <div class="myMsg">
                    <span class="msg">Nice to meet you, too.</span>
                </div> -->
            </div>
            <form class="chatForm" @submit.prevent="sendMessage">
                <!-- <input type="text" autocomplete="off" size="30" class="message" placeholder="메시지를 입력하세요"> -->
                <input class="message" autocomplete="off" placeholder="메시지를 입력하세요" v-model="message">
                <input type="submit" value="보내기">
            </form>
        </div>
        <button class="join-btn" v-else @click="joinroom">입장하기</button>
        <div class="memberWrap">
            <div class="memberList">
                <div class="memberHeader">사람</div>
                <div class="memberEl">{{userName}}(나)</div>
                <div class="memberEl" v-bind:key="item" v-for = "item in userList">{{item.user}}</div>
            </div>
        </div>
    </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import cookies from 'js-cookie'
import swal from 'sweetalert2'
export default {
    name : 'ChattingVue',
    data: function() {
        return {
            connection: null,
            userName: '',
            isJoined: false,
            selectedRoom: 'All',
            roomNum : '0',
            message: '',
            userList: [],
            chatLog: [],
        }
    },
    beforeCreate() {
      if (cookies.get('accessToken')) {
          axios.get(
            'http://localhost:80/getInfo',
            {
              headers: {
                'Authorization': `Bearer ${cookies.get('accessToken')}`
              }
            }
          )
          .then((Response) => {
            this.userName = Response.data.Member.name
          })
          .catch((error) => { 
            swal.fire({
                    icon: 'warning',
                    title: '연결이 종료되었습니다',
                    timer: 1500
                })            
            })
      } else {
          swal.fire({
                icon: 'warning',
                title: '로그인이 필요합니다',
                timer: 1500
            })            
            setTimeout(() => {
                   location.href= '/';
            }, 1000);
      }
    },
    methods: {
        logout() {
            cookies.remove('accessToken')
            location.href = '/'
        },
        joinroom() {
            const chatting = this;
            this.isJoined = true;  
            this.connection = new WebSocket("ws://127.0.0.1/chatting")
            this.connection.onopen = function() {
                console.log("연결 완료")
            }
            this.connection.onmessage = function(response) {
                var strArray = response.data.split('|')
                if (strArray[0] == "방 번호") {
                    chatting.roomNum = strArray[1]
                } else if (strArray[0] == "방 유저") {
                    chatting.userList.push({user:strArray[1]})
                } else if (strArray[0] == "사람 나감") {
                    chatting.userList.pop({user:strArray[1]})
                } else if (strArray[0] == "랜덤채팅") {
                    if (strArray[1] == chatting.userName) {
                        chatting.chatLog.push({user: "나", message: strArray[2]})
                        console.log(`내 메세지 : ${strArray[2]}`)
                    } else {
                        chatting.chatLog.push({user: strArray[1], message: strArray[2]})
                        console.log(`${strArray[1]}의 메세지 : ${strArray[2]}`)
                    }
                }
            } 
            this.connection.onclose = function(event) {
                swal.fire({
                    icon: 'error',
                    title: '한 계정으로 다중 접속은 불가능합니다',
                    timer: 1500
                })
                setTimeout(() => {
                    location.href = '/'
                }, 1000)
            }
            setTimeout(() => {
                this.connection.send("1|"+this.userName);  
            }, 100)
        },
        sendMessage() {
            this.connection.send("2|"+this.message);
            this.message = '';
        },
        selectAll() {
            this.selectedRoom = 'All';
        },
        selectRoom() {
            this.selectedRoom = 'Room';
        }
    },
}
</script>

<style lang="scss">
.overflow-hidden {
  overflow: hidden;
}

.roomWrap {
    width: 150px;
}

.roomList {
    border: 1px solid #0084FF;
    border-radius: 5px;
}

.roomHeader {
    background-color: #0084FF;
    color: #fff;
    height: 40px;
    font-size: 18px;
    line-height: 40px;
    text-align: center;
    border-radius: 5px;
}

.roomEl {
    text-align: center;
    border-bottom: 1px solid #f0f0f0;
    padding: 10px 0px;
    cursor: pointer;
}

.roomEl:hover{
    background: #f0f0f0;
}

.roomEl.active{
    background: #f0f0f0;
}

.join-btn {
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

.chatWrap {
    width: 600px;
    border: 1px solid #ddd;
}

.chatHeader {
    height: 60px;
    text-align: center;
    line-height: 60px;
    font-size: 25px;
    font-weight: 900;
    border-bottom: 1px solid #ddd;
}

.chatLog {
    height: 500px;
    overflow-y: auto;
    padding: 10px;
}

.myMsg {
    text-align: right;
}

.anotherMsg {
    text-align: left;
    margin-bottom: 5px;
}

.msg {
    display: inline-block;
    border-radius: 15px;
    padding: 7px 15px;
    margin-bottom: 10px;
    margin-top: 5px;

}

.anotherMsg > .msg {
    background-color: #f1f0f0;

}

.myMsg > .msg {
    background-color: #0084FF;
    color: #fff;
}

.anotherName {
    font-size: 12px;
    display: block;
}

.chatForm {
    display: block;
    width: 100%;
    height: 50px;
    border-top: 2px solid #f0f0f0;
}

.message {
    width: 85%;
    height: calc(100% - 1px);
    border: none;
    padding-bottom: 0;
}

.message:focus {
    outline: none;
}

.chatForm > input[type=submit] {
    outline: none;
    border: none;
    background: none;
    color: #0084FF;
    font-size: 17px;
}

.memberWrap{
    width: 200px;
}

.memberList {
    border: 1px solid #aaaaaa;
    border-radius: 5px;
}

.memberHeader {
    height: 40px;
    font-size: 18px;
    line-height: 40px;
    padding-left: 15px;
    border-bottom: 1px solid #f0f0f0;
    font-weight: 600;
}

.memberEl {
    border-bottom: 1px solid #f0f0f0;
    padding: 10px 20px;
    font-size: 14px;
    text-align: center;
}

.contentCover{
    width: 1280px;
    margin: 0 auto;
    padding-top: 20px;
    display: flex;
    justify-content: space-around;
}
</style>