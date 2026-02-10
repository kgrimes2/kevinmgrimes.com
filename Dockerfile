# Build the KDM React app
FROM node:20-alpine as node-build

# Install git to clone the submodule
RUN apk add --no-cache git

WORKDIR /kdm-app

# Accept build arguments for production configuration
ARG VITE_COGNITO_USER_POOL_ID
ARG VITE_COGNITO_CLIENT_ID
ARG VITE_COGNITO_DOMAIN
ARG VITE_COGNITO_REGION
ARG VITE_API_GATEWAY_URL

# Set environment variables for Vite build
ENV VITE_COGNITO_USER_POOL_ID=$VITE_COGNITO_USER_POOL_ID
ENV VITE_COGNITO_CLIENT_ID=$VITE_COGNITO_CLIENT_ID
ENV VITE_COGNITO_DOMAIN=$VITE_COGNITO_DOMAIN
ENV VITE_COGNITO_REGION=$VITE_COGNITO_REGION
ENV VITE_API_GATEWAY_URL=$VITE_API_GATEWAY_URL

# Clone the KDM app repository
RUN git clone https://github.com/kgrimes2/kdm-settlement-manager.git . && \
    npm ci && \
    npx vite build

# Build the Hugo site
FROM klakegg/hugo:ext-alpine as hugo-build

COPY ./ /site
WORKDIR /site

# Copy the built KDM app to static directory
COPY --from=node-build /kdm-app/dist /site/static/kdm/manager

RUN hugo

# Copy static files to Nginx
FROM nginx:alpine
COPY --from=hugo-build /site/public /usr/share/nginx/html

WORKDIR /usr/share/nginx/html
