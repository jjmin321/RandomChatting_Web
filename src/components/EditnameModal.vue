<template>
  <div class="editname-modal"  @keyup.enter="editname">
        <div class="editname-modal-area" @click="onClose"/>
        <div class="editname-modal-box">
            <h3 class="editname-modal-box-title">닉네임 변경</h3>
            <div class="editname-modal-box-form">
                <span>변경할 닉네임</span>
                <input v-model="name" type="text" placeholder="2~15자 이내로 입력해주세요" autofocus />
            </div>
            <button class="editname-modal-box-submit" @click="editname">변경하기</button>                
        </div>
  </div>
</template>

<script>
import axios from 'axios'
import swal from 'sweetalert2'
import cookies from 'js-cookie' // https://www.npmjs.com/package/js-cookie

export default {
    name: "editname-modal",
    data: () => {
        return {
            name: '',
        }
    },
    methods: {
        onClose() {
            this.$emit("onClose");
        },
        editname() {
            if (this.name.length < 2 || this.name.length > 15) {
                swal.fire({
                    icon: 'warning',
                    title: '닉네임을 2~15자 이내로 입력해주세요',
                    timer: 1500
                })
            } else {
                const name = JSON.stringify({
                    name: this.name
                })
                axios.patch(
                    'http://35.202.66.120:8080/patchName', name,
                    {
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': `Bearer ${cookies.get('accessToken')}`
                    },
                  }
                )
                .then((Response) => {
                    swal.fire({
                        icon: 'success', 
                        title: Response.data.message
                    })
                    setTimeout(() => {
                    this.onClose();
                    }, 1000);
                })
                .catch((error) => { 
                    swal.fire({
                        icon: 'warning',
                        title: error.response.data.message,
                        timer: 1500
                    })
                })
            }
        },  
        }
    }
</script>

<style lang="scss">
.editname-modal {
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