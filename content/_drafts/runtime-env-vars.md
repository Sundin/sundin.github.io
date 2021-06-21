---
title: "Runtime Environment Variables"
description: ""
date: "2021-06-21T10:58:32+02:00"
thumbnail: ""
categories:
  - ""
tags:
  - ""
draft: true
---


env.sh:

```sh
#!/bin/sh
# line endings must be \n, not \r\n !
echo "window._env_ = {" > ./public/env-config.js
awk -F '=' '{ print $1 ": \"" (ENVIRON[$1] ? ENVIRON[$1] : $2) "\"," }' ./.env >> ./public/env-config.js
echo "}" >> ./public/env-config.
```

In index.html:

```js
<script src="%PUBLIC_URL%/env-config.js"></script>
```

Add this command as the start script in package.json:

```
./env.sh && react-scripts start
```

Add `public/env-config.js` to `.gitignore`.

nginx.conf:

```nginx
server {

  listen 80;

  location / {
    root   /app;
    index  index.html index.htm;
    try_files $uri $uri/ /index.html;
  }
}

```


Dockerfile:

```dockerfile
FROM node:16-alpine3.13 as build
WORKDIR /work
COPY package.json ./
COPY package-lock.json ./
RUN npm ci
COPY nginx nginx
COPY .env .env
COPY env.sh env.sh
COPY tsconfig.json .
COPY public public
COPY types types
COPY src src

RUN npm run build

FROM nginx:stable-alpine as runtime

COPY --from=build /work/build /app
COPY --from=build /work/env.sh /app/env.sh
COPY --from=build /work/.env /app/.env
COPY --from=build /work/nginx/default.conf /etc/nginx/conf.d/default.conf

WORKDIR /app

EXPOSE 80

CMD ["/bin/sh", "-c", "/app/env.sh && nginx -g \"daemon off;\""]
```

https://github.com/kunokdev/cra-runtime-environment-variables
