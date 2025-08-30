# Stage 1: Build
FROM node:20-alpine AS builder
WORKDIR /root

COPY package.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Run
FROM node:20-alpine AS runner
WORKDIR /root

ENV NODE_ENV production
ENV PORT 3000

COPY --from=builder /root/package*.json ./
COPY --from=builder /root/.next ./.next
COPY --from=builder /root/node_modules ./node_modules

EXPOSE 3000
CMD ["npm", "start"]
