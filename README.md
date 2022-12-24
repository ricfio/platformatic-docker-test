# Platform Docker Test App

The goal of this project is test [Platformatic's official Docker Image v0.11.0](https://hub.docker.com/layers/platformatic/platformatic/v0.11.0/images/sha256-7011793799ff030678fec3fef8a589b5e8b77ed6e95def21c4bb170f79502c62?context=explore).  

These issues occurs on my 'Ubuntu 22.04.1 LTS (as WSL2 on Windows 10)':

1. Platformatic DB application is not available from Docker Host (working from Docker Container).

    ```console
    curl: (52) Empty reply from server
    ```

2. Platformat DB dashboard is enabled in `platformatic.db.json` but not available:

    ```console
    [10:42:05.694] WARN (6): "root" path "/home/platformatic/packages/db-dashboard/build" must exist
    ```

Solved as follow:

1. Change in .env `PLT_SERVER_HOSTNAME=127.0.0.1` in `PLT_SERVER_HOSTNAME=0.0.0.0`

## Build the Docker image and Run Docker container

Build the Docker image:

`docker build --no-cache -t app .`

Run Docker container (temporarly, because with `--rm` option it will be removed on exit):

`docker run --rm -p 3042:3042 --name app app`

```console
[10:42:05.678] INFO (6): dashboard plugin loaded.
[10:42:05.694] WARN (6): "root" path "/home/platformatic/packages/db-dashboard/build" must exist
[10:42:07.361] INFO (6): server listening
    url: "http://127.0.0.1:3042"
```

## Check from Docker Host

1. `curl http://127.0.0.1:3042/dashboard`

    ```console
    curl: (52) Empty reply from server
    ```

2. `curl http://127.0.0.1:3042/movies`

    ```console
    curl: (52) Empty reply from server
    ```

## Check from Docker Container

Enter inside Docker Container shell:  

`docker exec -it app /bin/sh`

1. `curl http://127.0.0.1:3042/dashboard`

    ```console
    {"message":"Route GET:/dashboard not found","error":"Not Found","statusCode":404}
    ```

2. `curl http://127.0.0.1:3042/movies`

    ```console
    [{"id":1,"name":"The Wizard of Oz"},{"id":2,"name":"Jaws"},{"id":3,"name":"Star Wars"},{"id":4,"name":"A Streetcar Named Desire"}]
    ```
