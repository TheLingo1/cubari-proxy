# Build stage
FROM node:18-alpine AS build

WORKDIR /app

# Add git to build stage for preval.macro
RUN apk add --no-cache git

# Copy package files
COPY package*.json ./
COPY pnpm-lock.yaml ./

# Install dependencies using npm (fallback if pnpm not available)
RUN npm ci
# this axios version is required in package-lock but didn't install locally for some reason so just in case
# RUN npm ci axios@0.21.4
# Also need cross-env because I modified the scripts in package.json to use it
# RUN npm ci cross-env

# Copy source code
COPY . .

# Build the app
RUN npm run build

# Production stage
FROM nginx:alpine

# Copy build files to nginx
COPY --from=build /app/build /usr/share/nginx/html

# Copy nginx configuration (optional - using default for now)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]