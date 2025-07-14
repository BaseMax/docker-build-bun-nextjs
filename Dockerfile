FROM oven/bun:alpine AS builder

ARG UID=0
ARG GID=0

WORKDIR /app

# RUN addgroup -g $GID appgroup && \
#     adduser -D -u $UID -G appgroup -h /app appuser

COPY package.json ./  
COPY bun.lock ./  

RUN bun install

COPY . .

# RUN chown -R appuser:appgroup /app
# USER appuser

RUN bun run build

FROM oven/bun:alpine

ARG UID=0
ARG GID=0

WORKDIR /app

# RUN addgroup -g $GID appgroup && \
#     adduser -D -u $UID -G appgroup -h /app appuser

COPY --from=builder /app/public ./public
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./

# RUN chown -R appuser:appgroup /app
# USER appuser

EXPOSE 3000

CMD ["bun", "run", "start"]
