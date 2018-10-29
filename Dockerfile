FROM node:10.12.0-alpine as builder
#RUN mkdir -p /app
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY package*.json /app/package.json
RUN npm install --silent
COPY ./ /app/
RUN npm run build --prod

EXPOSE 3000

# production environment
FROM nginx:1.13.9-alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]