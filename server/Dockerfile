FROM --platform=linux/arm64 amazon/aws-lambda-nodejs:18

# Install Yarn
RUN npm install -g yarn

# Copy the transpiled JavaScript files and package.json files
COPY dist/ ./dist/
COPY generated/ ./generated/
COPY package*.json yarn.lock ./

# Install production dependencies using Yarn
RUN yarn install --production

# Start the application
CMD ["dist/main.handler"]
