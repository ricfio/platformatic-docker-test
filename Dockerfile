FROM platformatic/platformatic:v0.11.0

USER root

WORKDIR /opt/app
COPY .env .env
COPY movie-quotes.sqlite movie-quotes.sqlite
COPY platformatic.db.json platformatic.db.json

EXPOSE 3042

CMD ["platformatic", "db"]

RUN apk add curl
