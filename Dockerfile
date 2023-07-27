# dockerfile for VIV environment
#
# KnowledgeVis, LLC
# all rights reserved

FROM python:3.8-slim-buster

# update installation
RUN apt-get update -y

# install the node version manager and have it enable a particular
# version of node.js

ENV NODE_VERSION=16.14.0
RUN apt install -y curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

# install pnpm since this is needed for the Viv repository
RUN npm install -g pnpm

# install the ViV app itself
RUN apt install -y git
RUN git clone https://github.com/hms-dbmi/viv.git
WORKDIR viv
RUN pnpm install
RUN pnpm build

#ENTRYPOINT pnpm dev --host --port 3000

# if the host is windows, I couldn't get the scriptfile to run, so
# we just build the app and serve AVIVATOR using the python HTTP server

EXPOSE 3000
WORKDIR sites/avivator/dist
ENTRYPOINT ["python","-m","http.server","3000"]

# if host is linux or Mac, the Windows commands above will work. 
# we can also do a data server as well.  Comment the lines above and 
# uncomment the lines below.  We will run both viv and a data server.
# by calling them from the shartup shell. It is assumed we have images 
# stored in the /data partition on the container.  Both servers are started
# from a shell script. 

#WORKDIR /
#COPY . .
#ENTRYPOINT ["sh","startup.sh"]