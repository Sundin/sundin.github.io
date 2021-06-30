---
title: "Runtime Environment Variables in the Browser"
date: "2021-06-30T10:58:32+02:00"
categories:
  - Tutorial
tags:
  - NGINX
  - Kubernetes
  - React
  - Vue
slug: runtime-env-vars
---

A limitation to all web development frameworks is that environment variables has to be injected during build time in order to made be available in the browser. If we have packaged our web application using Docker, that means that we would need to build a different container image for each different environment where we will want to host our application. This is a waste of resources and also introduces a risk of us ending up with a different codebase in our production environment than what we tried out in our QA or test environment. 

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

The above solution should work fine for most scenarios, but some modifications had to be made in order to get it to work in our Kubernetes cluster as well. The reason is that write permissions are locked down by default for security reasons. In order to mark a folder as writable, we need to mount it as an `emptyDir` in our pod specification, but that will in turn erase any content already at that path. The solution is to place `env-config.js` in a subfolder called `env` which we mount as an `emptyDir`.

In order to do this, simply replace all occurences of `env-config.js` above with `env/env-config.js`.

And finally mount the `emptyDir` in the pod specification (we use Kustomize for this). NGINX also needed write access to a few folders, which was accomplished in the same manner.

```yaml
apiVersion: apps/v1
kind: Deployment
spec:
  template:
    spec:
      containers:
        - name: runtime-env-vars-demo
          volumeMounts:
            - mountPath: /var/cache/nginx
              name: nginx-cache-volume
            - mountPath: /var/run
              name: nginx-run-volume
            - mountPath: /app/env
              name: runtime-env-vars-volume
      volumes:
        - name: nginx-cache-volume
          emptyDir: {}
        - name: nginx-run-volume
          emptyDir: {}
        - name: runtime-env-vars-volume
          emptyDir: {}
```

## Credits

Most of this solution was found [here](https://github.com/kunokdev/cra-runtime-environment-variables). Check it out for more details as well as some additional considerations in the [issues](https://github.com/kunokdev/cra-runtime-environment-variables/issues?q=is%3Aissue)!
