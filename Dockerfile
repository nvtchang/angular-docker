FROM node:18-alpine

RUN addgroup app && adduser -S -G app app
RUN npm install -g @angular/cli

RUN mkdir /app && chown app:app /app

USER app

WORKDIR /app
RUN mkdir data
# Copy package.json and package-lock.json to make use of Docker cache
# Copy package.json files with ownership
COPY --chown=app:app package*.json ./

RUN npm install

#Copy source code
COPY --chown=app:app . .

ENV API_PATH=http://api.localhost

EXPOSE 4200

# CMD [ "npm", "start" ]

ENTRYPOINT [ "ng", "serve","--host", "0.0.0.0", "--disable-host-check" ]