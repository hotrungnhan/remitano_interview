FROM node:18-alpine3.17 as build

WORKDIR /app
COPY . /app

RUN corepack enable
RUN pnpm install
RUN pnpm run build

FROM nginx:stable-alpine-perl

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx","-g","daemon off;"]
