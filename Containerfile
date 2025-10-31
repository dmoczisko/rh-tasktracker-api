# Base image: Red Hat UBI with Node.js 20
FROM registry.access.redhat.com/ubi8/nodejs-20

# Switch to root for installing dependencies
USER root

# Set working directory
WORKDIR /usr/src/app

# Copy package.json first (better caching)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app
COPY . .

# Ensure ownership for non-root user
RUN chown -R 1001:1001 /usr/src/app

# Switch to non-root user for running the app
USER 1001

# Expose the port your app listens on
EXPOSE 3000

# Healthcheck (optional but good practice)
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

# Command to run the app
CMD ["node", "app.js"]
