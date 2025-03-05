FROM node:23-alpine3.20

WORKDIR /usr/src/app/

COPY package.json .
COPY package-lock.json .

RUN npm ci

COPY . .

RUN npx prisma generate
RUN npm run build

CMD [ "npm", "run", "start" ]