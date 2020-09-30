FROM node:12.18.4-alpine3.12

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY index.js .

CMD ["npm", "start"]
