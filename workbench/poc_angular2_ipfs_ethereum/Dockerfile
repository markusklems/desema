FROM node

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install ng
RUN npm install -g angular-cli
# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install
COPY . /usr/src/app/

CMD ["ng", "server", "--host", "0.0.0.0", "--port", "4200"]
