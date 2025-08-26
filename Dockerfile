# Use the official Node.js 22 image.
FROM node:22-alpine

# Create and change to the app directory.
WORKDIR /usr/src/app

# Copy application dependency manifests to the container image.
# A wildcard is used to ensure both package.json AND package-lock.json are copied.
# Copying this separately prevents re-running npm install on every code change.
COPY package*.json ./

# Install production dependencies.
RUN npm install --only=production

# Copy local code to the container image.
COPY . .

# Build the application.
RUN npm run build

# Expose the port that the application will run on.
EXPOSE 3001

# Run the web service on container startup.
CMD [ "npm", "run", "start:prod" ]
