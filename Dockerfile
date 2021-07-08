## this is the stage one , also know as the build step

FROM node:15
WORKDIR /usr/src/app
COPY package*.json ./
COPY . .
RUN npm install
RUN npm run build

## this is stage two , where the app actually runs

FROM node:15

# RUN  apt-get update \
#      && apt-get install -y wget gnupg ca-certificates \
#      && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
#      && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
#      && apt-get update \
#      # We install Chrome to get all the OS level dependencies, but Chrome itself
#      # is not actually used as it's packaged in the node puppeteer library.
#      # Alternatively, we could could include the entire dep list ourselves
#      # (https://github.com/puppeteer/puppeteer/blob/master/docs/troubleshooting.md#chrome-headless-doesnt-launch-on-unix)
#      # but that seems too easy to get out of date.
#      && apt-get install -y google-chrome-stable \
#      && rm -rf /var/lib/apt/lists/* \
#      && wget --quiet https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -O /usr/sbin/wait-for-it.sh \
#      && chmod +x /usr/sbin/wait-for-it.sh

WORKDIR /usr/src/app
COPY package*.json ./
COPY .sequelizerc ./.sequelizerc
# COPY src/config/sequelize.js ./src/config/sequelize.js 
# COPY src/database/migrations ./src/database/migrations
RUN npm install --only=production
COPY --from=0 /usr/src/app/dist ./dist
COPY devops/.docker/start.sh /usr/local/bin/start
RUN chmod +x /usr/local/bin/start
EXPOSE 3000
EXPOSE 80

CMD ["/usr/local/bin/start"]