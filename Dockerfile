FROM node:20

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN npm build

EXPOSE 1337

CMD ["npm", "start"]
