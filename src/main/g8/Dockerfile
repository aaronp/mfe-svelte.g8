# https://sveltesociety.dev/recipes/publishing-and-deploying/dockerize-a-svelte-app
FROM node:19 AS build

WORKDIR /app

# conditionally copy node_modules if available (e.g. we've done a local build)
# see https://stackoverflow.com/questions/31528384/conditional-copy-add-in-dockerfile
#
# also -- package-lock.json, yarn.lock, whatever ... just copy the lock file if there
COPY package.json *lock* node_module[s] ./

COPY . ./

RUN yarn
RUN yarn build

FROM nginx:1.19-alpine
COPY --from=build /app/public /usr/share/nginx/html

EXPOSE 3000

RUN mkdir -p /usr/share/nginx/html/assets/js/
RUN mkdir -p /usr/share/nginx/html/assets/css/

COPY --from=build /app/target/assets/*.svg /usr/share/nginx/html/assets/
COPY --from=build /app/target/assets/css/index.css /usr/share/nginx/html/assets/css/index.css
COPY --from=build /app/target/assets/js/*.js /usr/share/nginx/html/assets/js/bundle.js
COPY --from=build /app/target/index.html /usr/share/nginx/html/index.html