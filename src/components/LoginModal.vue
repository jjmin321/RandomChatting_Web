<template>
  <div class="login-modal">
        <div class="login-modal-area" @click="onClose"/>
        <div class="login-modal-box">
            <h3 class="login-modal-box-title">로그인</h3>
            <div class="login-modal-box-form">
                <span>ID</span>
                <input v-model="id" type="text" placeholder="아이디를 입력해주세요." autofocus />
            </div>

            <div class="login-modal-box-form">
                <span>PW</span>
                <input v-model="pw" type="text" placeholder="비밀번호를 입력해주세요." />
            </div>
        </div>
  </div>
</template>

<script>
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
        }
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
    }
}

</style>