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

A limitation to all web development frameworks is that environment variables has to be injected during build time in order to be available in the browser. If we have packaged our web application using Docker, that means that we would need to build a different container image for each different environment where we will want to host our application. This is a waste of resources and also introduces a risk of us ending up with a different codebase in our production environment than what we tried out in our QA or test environment. 

In this blog post I will describe another approach, where it is possible to inject environment variables during runtime instead. This means that we can use the same container image in all our environments and just change the environment variables available to each running container.

Start by creating a `.env` file. This file will be populated with the environment variables to use during local development (i.e., when starting the application using `npm start` rather than Docker).

```
MY_ENV_VAR=some_value
ANOTHER_ENV_VAR=another_value
```

Next create a small script called `env.sh` that will output a JavaScript file containing our runtime environment variables. Remember to make it executable with `chmod +x env.sh`.

```sh
#!/bin/sh
# line endings must be \n, not \r\n !
echo "window._env_ = {" > ./public/env-config.js
awk -F '=' '{ print $1 ": \"" (ENVIRON[$1] ? ENVIRON[$1] : $2) "\"," }' ./.env >> ./public/env-config.js
echo "}" >> ./public/env-config.
```

Add the follwoing line to `index.html` in order to access the environment variables when the user visits the running web application.

```js
<script src="%PUBLIC_URL%/env-config.js"></script>
```

Change the start script in `package.json` to also execute the bash script before starting the web server (example for create-react-app, change as applicable for your frontend framework).

```
./env.sh && react-scripts start
```

The environment variables are now accessible from your JavaScript code as `window._env_.MY_ENV_VAR` and `window._env_.ANOTHER_ENV_VAR`.

You can also add `public/env-config.js` to `.gitignore`.

## Docker

When running with Docker, we will use an image with node and npm installed to build the container image, and a lightweight NGINX image to run it.

First create a simple NGINX configuration file (`nginx/default.conf`):

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

The `Dockerfile` looks as follows. Remember to execute the `env.sh` script when NGINX starts up.

```dockerfile
FROM node:16-alpine3.13 as build
WORKDIR /work
COPY package.json ./
COPY package-lock.json ./
RUN npm ci
COPY . .
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

## Kubernetes

https://github.com/kunokdev/cra-runtime-environment-variables
