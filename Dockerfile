FROM node:alpine as builder

WORKDIR /opt/adrian
ADD . .

RUN npm install
RUN npm rebuild node-sass --force
RUN npm run build-css

FROM nginx
WORKDIR /usr/share/nginx/html

RUN rm ./*

COPY --from=builder /opt/adrian/public /usr/share/nginx/html

EXPOSE 80