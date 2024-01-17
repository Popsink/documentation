# documentation

We are using [material for mkdocs](https://squidfunk.github.io/mkdocs-material/).

## Local
If you don't mind cluterring your global Python env with additional packages

### Install

```
pip install -r requirements.txt
```

### Serve

```
mkdocs serve
```

## Docker
If you DO mind cluterring your Python env and prefer to use Docker instead

### Build the Docker image
This step is automatic executed before every other target to ensure you have the updated image, you shouldn't need to run it manually

```
make docker-build
```

### Serve
By default, it will expose the container on port `8000`.

You can override it by adding `PORT=1234` after your `make` command

```
make serve
```
or
```
make serve PORT=8888
```

### Build
To locally build the documentation into `site/`, if you want to take a look at the produced assets.

Don't worry, this directory is ignored.

```
make build
```
