
FROM node:20-alpine AS build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Serve the built application (for static sites)
FROM nginx:alpine AS runtime-static
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80