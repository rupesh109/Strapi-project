FROM node:20

# Set working directory
WORKDIR /app

# Copy dependencies and install
COPY package*.json ./
RUN npm install

# Copy rest of the project files
COPY . .

# Build the Strapi admin panel
RUN npm run build

# Expose the default Strapi port
EXPOSE 1337

# Start the application
CMD ["npm", "start"]
