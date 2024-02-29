FROM node:20.11.1-slim AS deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
FROM node:20.11.1-slim AS pre-build
WORKDIR /app
COPY . .
COPY --from=deps /app/node_modules ./node_modules
RUN npm run build
FROM node:20.11.1-slim AS build
WORKDIR /app
COPY --from=pre-build /app/next.config.mjs ./
COPY --from=pre-build /app/public ./public
COPY --from=pre-build /app/.next ./.next
COPY --from=pre-build /app/node_modules ./node_modules
COPY --from=pre-build /app/package.json ./package.json
COPY --from=pre-build /app/package-lock.json ./package-lock.json
COPY pm2.json ./pm2.json
EXPOSE 3000
RUN npm install pm2 -g
RUN npx next telemetry disable
CMD ["npm", "run", "pm2", "start", "pm2.json"]
