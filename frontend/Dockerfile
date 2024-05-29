FROM node:18-alpine3.17 as build

WORKDIR /app
COPY . /app
# Define build arguments for environment variables
ARG VITE_BASE_URL
ARG VITE_BASE_WS_URL

# Set environment variables during the build process
ENV VITE_BASE_URL=$VITE_BASE_URL
ENV VITE_BASE_WS_URL=$VITE_BASE_WS_URL



RUN corepack enable
RUN pnpm install

RUN pnpm run build



FROM nginx:stable-alpine-perl

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx","-g","daemon off;"]
