# Build stage
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package file
COPY package.json ./

# Install dependencies using npm
RUN npm install --production=false

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Runtime stage
FROM node:20-alpine

WORKDIR /app

# (runtime) no package manager required

# Copy built application from builder
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static

# Expose port
EXPOSE 3000

# Start the application
CMD ["node", "server.js"]
