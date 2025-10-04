FROM node:14-alpine3.13 AS base

WORKDIR /app

RUN apk add --no-cache gcompat=1.0.0-r1

COPY package*.json ./

RUN npm ci --omit=dev

COPY . .

ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000

CMD ["node", "server.js"]


