<template>
  <div>
      <header class="header">
      <div class="header-container">
        <div class="header-profile">
          <span class="header-profile-name" >{{userName}} 님, 안녕하세요</span>
        </div>
        <button class="header-right-btn" @click="logout">로그아웃</button>
        <div @click="descriptionModalOpen" class="header-description" >?</div>
      </div>
    </header>

    <div class="contentWrap">
    <div class="contentCover">
        <div class="roomWrap">
            <div class="roomList">
                <div class="roomHeader">채팅 방 목록</div>
                <div class="roomSelect">
                    <div @click="selectRoom" class="roomEl" :class="{ active: filteredChatLog === roomChatLog }" data-class="2">랜덤 채팅</div>
                    <div @click="selectAll" class="roomEl" :class="{ active: filteredChatLog === allChatLog}" data-class="1">전체 채팅</div>
                </div>
            </div>
            <button class="roomQuit" v-if="isJoined == true" @click="quitroom">채팅방 나가기</button>
        </div>
        <div class="chatWrap" v-if="isJoined == true">
            <div class="chatHeader" v-if="filteredChatLog === allChatLog">전체 채팅</div>
            <div class="chatHeader" v-else>랜덤 채팅</div>
            <div ref="chatBox" class="chatLog">
                <div v-bind:key="item" v-for= "item in filteredChatLog">
                <div class="myMsg" v-if ="item.user == '나' ">
                    <span class="msg">{{item.message}}</span>
                </div>
                <div class="noticeMsg" v-else-if="item.user == '고'">
                    <span>{{item.notice}}</span>
                </div>
                <div class="anotherMsg" v-else>
                    <span class="anotherName">{{item.user}}</span>
                    <span class="msg">{{item.message}}</span>
                </div>
                </div>
            </div>
            <form class="chatForm" @submit.prevent="sendMessage">
                <input id="message-box" autofocus class="message" autocomplete="off" placeholder="메시지를 입력하세요" v-model="message" maxlength="100" :readonly="chatCoolTime">
                <input type="submit" value="보내기">
            </form>
        </div>
        <button class="join-btn" v-else @click="[joinroom(), selectRoom()]">입장하기</button>
        <div class="memberWrap">
            <div class="memberList">
                <div class="memberHeader">사람</div>
                <div class="memberEl">{{userName}}(나)</div>
                <div class="memberEl" v-bind:key="item" v-for = "item in filteredUserList">{{item}}</div>
            </div>
        </div>
    </div>
    </div>
    <description-modal v-if="descriptionModal" @onClose="descriptionModalClose" />
  </div>
</template>

<script>
import axios from 'axios'
import cookies from 'js-cookie'
import swal from 'sweetalert2'
import DescriptionModal from "@/components/DescriptionModal"
export default {
    name : 'ChattingVue',
    data: function() {
        return {
            descriptionModal: false,
            connection: null,
            userName: '',
            deleteUser: '',
            isJoined: false,
            roomNum : '0',
            message: '',
            allUserList: [],
            roomUserList: [],
            filteredUserList: [],
            allChatLog: [],
            roomChatLog: [],
            filteredChatLog: [],
            chatCoolTime : false
        }
    },
    components: {
        DescriptionModal,
    },
    watch: {
        filteredChatLog: function(val) {
            const chatLogEl = document.getElementsByClassName('chatLog')[0]
                setTimeout(() => {
                    chatLogEl.scrollTop = chatLogEl.scrollHeight;
                }, 5)

            const inputEl = document.getElementById('message-box')

            if (inputEl) {
                inputEl.focus()
            }
        }
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
                timer: 1000
            })            
            setTimeout(() => {
                   location.href= '/';
            }, 500);
      }
    },
    methods: {
        descriptionModalOpen() {
            this.descriptionModal = true;
        },
        descriptionModalClose() {
            this.descriptionModal = false;
        },
        serverModalOpen() {
            this.serverModal = true;
        },
        serverModalClose() {
            this.serverModal = false;
        },
        logout() {
            cookies.remove('accessToken')
            location.href = '/'
        },
        joinroom() {
            const chatting = this;
            this.isJoined = true;  
            this.connection = new WebSocket("ws://34.64.214.238:8080/chatting")
            this.connection.onopen = function() {
                // console.log("정상적으로 연결되었습니다")
            }
            this.connection.onmessage = function(response) {
                const chatLogEl = document.getElementsByClassName('chatLog')[0]
                var strArray = response.data.split('ᗠ')
                if (strArray[0] == "방 번호") {
                    chatting.roomNum = strArray[1]
                } else if (strArray[0] == "전체 유저 정보") {
                    chatting.allUserList.push(strArray[1])
                } else if (strArray[0] == "방 유저 정보") {
                    chatting.roomUserList.push(strArray[1])
                } else if (strArray[0] == "전체 유저 접속") {
                    chatting.allChatLog.push({user:'고', notice: strArray[1]+"님이 입장하셨습니다"})
                    if (strArray[1] != chatting.userName) {
                        chatting.allUserList.push(strArray[1])   
                    }
                } else if (strArray[0] == "방 유저 접속") {
                    chatting.roomChatLog.push({user:'고', notice: strArray[1]+"님이 입장하셨습니다"})
                    if (strArray[1] != chatting.userName) {
                        chatting.roomUserList.pop(strArray[1])
                        chatting.roomUserList.push(strArray[1])
                    }
                } else if (strArray[0] == "사람 나감") {
                    if (chatting.allUserList.indexOf(strArray[2]) != -1) {
                        chatting.allChatLog.push({user:'고', notice: strArray[2]+"님이 퇴장하셨습니다"})    
                        chatting.allUserList.splice(chatting.allUserList.indexOf(strArray[2]), 1)
                        // 유저가 나갔을 때 or 다중 접속으로 강제 퇴장 당한 유저가 같은 랜덤 채팅방일 때
                        if (chatting.roomNum == strArray[1] || chatting.roomUserList.indexOf(strArray[2]) != -1) {
                            chatting.roomChatLog.push({user:'고', notice: strArray[2]+"님이 퇴장하셨습니다"}) 
                            chatting.roomUserList.pop()
                        }
                    }
                } else if (strArray[0] == "랜덤채팅") {
                    if (strArray[1] == chatting.userName) {
                        chatting.roomChatLog.push({user: "나", message: strArray[2]})
                    } else {
                        chatting.roomChatLog.push({user: strArray[1], message: strArray[2]})
                    }
                } else if (strArray[0] == "전체채팅") {
                    if (strArray[1] == chatting.userName) {
                        chatting.allChatLog.push({user: "나", message : strArray[2]})
                    } else {
                        chatting.allChatLog.push({user: strArray[1], message: strArray[2]})
                    }
                } else if (strArray[0] == "접속중") {
                    swal.fire({
                        icon: 'error',
                        title: '한 계정으로 다중 접속은 불가능합니다',
                        timer: 1500
                    })
                    chatting.quitroom();
                }
                setTimeout(() => {
                    chatLogEl.scrollTop = chatLogEl.scrollHeight;
                }, 5)
            } 
            this.connection.onclose = function(event) {
                chatting.isJoined = false;
            }
            setTimeout(() => {
                this.connection.send("1ᗠ"+this.userName);  
            }, 750)
        },
        quitroom() {
            this.connection.close();
            location.href = '/chatting'
            
        },
        sendMessage() {
            if (this.filteredChatLog === this.allChatLog) {
                this.sendMessageToAll();
            } else {
                this.sendMessageToRoom();
            }
        },
        sendMessageToRoom() {
            if (!this.message.trim()) {
                return;
            } else {
                this.connection.send("2ᗠ"+this.message);
                this.message = '';
                this.chatCoolTime = true;
                setTimeout(() => {
                    this.chatAble();
                }, 1000)
            }
        },
        sendMessageToAll() {
            if (!this.message.trim()) {
                return;
            } else {
                this.connection.send("3ᗠ"+this.message);
                this.message = '';
                this.chatCoolTime = true;
                setTimeout(() => {
                    this.chatAble();
                }, 1000)
            }
        },
        selectAll() {
            this.filteredChatLog = this.allChatLog
            this.filteredUserList = this.allUserList
        },
        selectRoom() {
            this.filteredChatLog = this.roomChatLog
            this.filteredUserList = this.roomUserList
        },
        chatAble() {
            this.chatCoolTime = false;
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
    border: 1px solid paleturquoise;
    border-radius: 5px;
}

.roomHeader {
    background-color: paleturquoise;
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

.roomQuit {
    width: 150px;
    height: 50px;
    background-color: #7600FF;
    margin-top: 250px;
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
    outline: none;
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

.noticeMsg {
    text-align: center;
}

.msg {
    display: inline-block;
    border-radius: 15px;
    padding: 7px 15px;
    margin-bottom: 10px;
    margin-top: 5px;
    word-break: break-all;
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
    padding-left: 10px;
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