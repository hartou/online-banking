# Stage 1: Build the Angular app
FROM node:14 as build
RUN npm install -g @angular/cli@9.1.7
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .

RUN ng build --prod

# # Stage 2: Serve the app with Nginx
FROM nginx:1.19.2-alpine
COPY --from=build /app/dist/online-banking /usr/share/nginx/html
# COPY nginx.conf /etc/nginx/conf.d/default.conf
# Expose port 80
EXPOSE 80

# # Start Nginx
CMD ["nginx", "-g", "daemon off;"]