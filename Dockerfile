FROM platformatic/platformatic:latest

USER root

WORKDIR /opt/app
COPY dist .
COPY .env .env
COPY movie-quotes.sqlite movie-quotes.sqlite
COPY platformatic.db.json platformatic.db.json

EXPOSE 3042

CMD ["platformatic", "start"]
RUN apk add curl

#ENTRYPOINT ["tail", "-f", "/dev/null"] // Allows developers to exec bash command to debug container internals

