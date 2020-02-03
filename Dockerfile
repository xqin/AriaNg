FROM node:10 as builder

WORKDIR /opt/nodeapp

COPY package.json .

RUN npm config set registry http://registry.npm.taobao.org/ \
    && npm install -ddd --no-optional \
    && npm cache clean -f

COPY ./src ./src

COPY gulpfile.js .

RUN npx gulp clean build

FROM nginx:latest

WORKDIR /usr/share/nginx/html

COPY --from=builder /opt/nodeapp/dist/ .
