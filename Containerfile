# Base image: Red Hat UBI with Node.js 20
FROM registry.access.redhat.com/ubi8/nodejs-20

# Set working directory inside container
WORKDIR /usr/src/app

# Copy package.json first (better caching)
COPY package*.json ./

# Install dependencies inside container
RUN npm install

# Copy the rest of the app files
COPY . .

# Expose the port your app will listen on
EXPOSE 3000

# Command to run your app
CMD ["node", "app.js"]
