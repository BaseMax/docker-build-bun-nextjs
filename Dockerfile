FROM docker.arvancloud.ir/oven/bun:alpine AS builder

ARG UID=0
ARG GID=0

WORKDIR /app

COPY package.json ./  
COPY bun.lock ./  

RUN bun install

COPY . .

RUN bun run build

FROM docker.arvancloud.ir/oven/bun:alpine

ARG UID=0
ARG GID=0

WORKDIR /app

COPY --from=builder /app/public ./public
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./

EXPOSE 3000

CMD ["bun", "run", "start"]
