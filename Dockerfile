# Use an official Node.js image as base
FROM node:18 AS builder

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install --omit=dev

# Install PM2 globally
RUN npm install pm2 pm2-runtime

# Copy Application files
COPY . .

# ---- Production Stage ----
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy application files from builder stage
COPY --from=builder /app /app

# Install PM2 in production stage
RUN npm install pm2 pm2-runtime --global

# Expose ports for Nginx and Node.js
EXPOSE 3000

# Start both PM2 (Node.js) and Nginx
CMD ["pm2-runtime", "ecosystem.config.js"]
