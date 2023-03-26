# https://sveltesociety.dev/recipes/publishing-and-deploying/dockerize-a-svelte-app
FROM node:19 AS build

WORKDIR /app

# conditionally copy node_modules if available (e.g. we've done a local build)
# see https://stackoverflow.com/questions/31528384/conditional-copy-add-in-dockerfile
COPY package.json package-lock.json node_module[s] ./

RUN npm install
COPY . ./
RUN npm run build

FROM nginx:1.19-alpine
COPY --from=build /app/public /usr/share/nginx/html

EXPOSE 3000

# svelte will create random IDs for our gnerated components, e.g. "dist/assets/index-65be3931.css"
# we rename in our build for conssitent IDs
COPY --from=build /app/dist/assets/svelte-*.svg /usr/share/nginx/html/assets/svelte.svg
COPY --from=build /app/dist/assets/index-*.css /usr/share/nginx/html/bundle.css
COPY --from=build /app/dist/assets/index-*.js /usr/share/nginx/html/bundle.js
COPY --from=build /app/dist/index.html /usr/share/nginx/html/index.html