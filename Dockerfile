FROM node:18-alpine AS base

WORKDIR /app

# Instala dependências do sistema necessárias para build de libs nativas se houver
RUN apk add --no-cache libc6-compat

COPY package*.json ./

RUN npm ci --omit=dev

COPY . .

ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000

CMD ["node", "server.js"]


