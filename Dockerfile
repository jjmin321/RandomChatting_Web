FROM node:12.18.3

LABEL Author="jjmin321@naver.com"

COPY . .

RUN npm install 

CMD ["npm", "run", "dev"]

EXPOSE 80

