# Use the official Node.js 22 image.
FROM node:22-alpine

# Create and change to the app directory.
WORKDIR /usr/src/app

# Copy application dependency manifests to the container image.
# A wildcard is used to ensure both package.json AND package-lock.json are copied.
# Copying this separately prevents re-running npm install on every code change.
COPY package*.json ./

# Install all dependencies, including devDependencies.
RUN npm install

# Copy local code to the container image.
COPY . .

# Build the application.
RUN npm run build

# Remove devDependencies.
RUN npm prune --production

# Expose the port that the application will run on.
EXPOSE 3000

# Run the web service on container startup.
CMD [ "npm", "run", "start:prod" ]