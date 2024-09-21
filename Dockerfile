# Use Node.js official image as the base
FROM node:18

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Expose the port json-server will run on
EXPOSE 3000

# Command to run json-server with a specified json file
CMD ["npx", "json-server", "--watch", "db.json", "--port", "3000"]
