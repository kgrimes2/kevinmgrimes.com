# Build the KDM React app
FROM node:20-alpine as node-build

COPY kdm-app /kdm-app
WORKDIR /kdm-app

RUN npm ci && npx vite build

# Build the Hugo site
FROM klakegg/hugo:ext-alpine as hugo-build

COPY ./ /site
WORKDIR /site

# Copy the built KDM app to static directory
COPY --from=node-build /kdm-app/dist /site/static/kdm

RUN hugo

# Copy static files to Nginx
FROM nginx:alpine
COPY --from=hugo-build /site/public /usr/share/nginx/html

WORKDIR /usr/share/nginx/html
