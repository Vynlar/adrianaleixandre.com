FROM node as builder

WORKDIR /opt/adrian
ADD . .

RUN npm install
RUN npm run build

FROM nginx
WORKDIR /usr/share/nginx/html

RUN rm ./*

COPY --from=builder /opt/adrian/public /usr/share/nginx/html

EXPOSE 80