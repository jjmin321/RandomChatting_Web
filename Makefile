# dockerfile 빌드 
.PHONY: build
build:
	@docker build --tag randomchatting_web .

# 웹 컨테이너 실행, 접속 
.PHONY: run
run:
	@docker run -i -t -p 80:80/tcp --name web randomchatting_web 

# 실행된 dockerfile 컨테이너, 이미지 삭제 
.PHONY: rm
rm:
	@docker rm web 
	@docker rmi randomchatting_web