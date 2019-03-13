FROM node:11.11.0

RUN apt-get update && apt-get install -y curl git python3 make build-essential libzmq3-dev python2.7 libunwind-dev node-gyp --no-install-recommends

RUN mkdir -p /usr/src/app
RUN mkdir  ~/.ravencore/
ADD ravencore-node.json /root/.ravencore/ravencore-node.json

RUN git clone https://github.com/bitnaive/ravencore-node /usr/src/app/ravencore-node
WORKDIR /usr/src/app/ravencore-node
RUN npm install

RUN /usr/src/app/ravencore-node/bin/ravencore-node create mynode

RUN git clone https://github.com/bitnaive/insight-api /usr/src/app/insights-api
WORKDIR /usr/src/app/insights-api
RUN npm install


WORKDIR /usr/src/app/ravencore-node/mynode
RUN /usr/src/app/ravencore-node/bin/ravencore-node install /usr/src/app/insights-api


ADD ravencore-node.json /usr/src/app/ravencore-node/mynode
WORKDIR /usr/src/app/ravencore-node/mynode
CMD ["/usr/src/app/ravencore-node/bin/ravencore-node", "start"]

#RUN npm install --production
