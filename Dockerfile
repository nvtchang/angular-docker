FROM node:18-alpine

RUN addgroup app && adduser -S -G app app

WORKDIR /app

# Copy package.json and package-lock.json to make use of Docker cache
COPY package*.json ./

# Cấp quyền cho user app trước khi npm install
RUN chown -R app:app /app

RUN npm install

#Copy source code
COPY . . 

ENV API_PATH=http://api.localhost

EXPOSE 4200

# CMD [ "npm", "start" ]
RUN npm install -g @angular/cli

ENTRYPOINT [ "ng", "serve","--host", "0.0.0.0", "--disable-host-check" ]