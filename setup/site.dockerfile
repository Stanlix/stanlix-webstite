# Compile front-end assets
FROM node:10
ENV SOURCE_DIR /site
WORKDIR $SOURCE_DIR
COPY package.json  $SOURCE_DIR/
COPY package-lock.json  $SOURCE_DIR/
RUN npm install
COPY ./src  $SOURCE_DIR/src
COPY ./webpack.mix.js $SOURCE_DIR/
COPY ./tailwind.js $SOURCE_DIR/
RUN npm run production

FROM nginx:1.10
ENV SITE_DIR /var/www/site
COPY --from=0 /site/public $SITE_DIR
COPY setup/site.nginx.conf /etc/nginx/conf.d/default.conf