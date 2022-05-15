# arm-2011.09-70-arm-none-linux-gnueabi

## Build up the docker image locally

```
docker build --pull --rm -f "Dockerfile" -t ${LABEL}:latest "."
```

`${LABEL}` could any string.

## How to use this tool chain

1. Pull the newest version from the DockerHub. If your version is already the latest, just go to step 2.
    ```
    docker pull dockerhy/arm-none-linux-gnueabi
    ```
2. Run the following command in the working directory:
    - On Mac:
    ```
    docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp dockerhy/arm-none-linux-gnueabi ${CMD}
    ```
    - On Windows:
    ```
    docker run --rm -v %cd%:/usr/src/myapp -w /usr/src/myapp dockerhy/arm-none-linux-gnueabi ${CMD}
    ```
    where `${CMD}` could be any command that is supported by this image, such as `make`, `make clean`.
