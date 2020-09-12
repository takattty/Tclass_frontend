FROM node:14.4.0-alpine

ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo
ENV HOST=0.0.0.0

ENV FRONTEND_ROOT /frontend
WORKDIR /$FRONTEND_ROOT

RUN apk update && \
    apk upgrade && \
    yarn install --no-progress --registry http://registry.npmjs.org/ && \
    rm -rf /var/cache/apk/* && \
    apk add python make g++

CMD [ "yarn", "run","dev" ]