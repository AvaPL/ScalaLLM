# ScalaLLM

An attempt to implement an LLM in Scala from scratch.

The ideas and code are based on
[Build a Large Language Model (From Scratch)](https://www.manning.com/books/build-a-large-language-model-from-scratch).

## Running locally

To run locally, use:

```shell
docker-compose up --build -d
```

To find the URL of the Jupyter server, use:

```shell
docker logs scalallm-jupyter-scala 2>&1 | grep '127.0.0.1'
```

The URL will be different each time because of access tokens. Access tokens are needed to prevent execution of arbitrary
code on the server.

### Working with notebooks

Notebooks are stored in the `workspace` directory and are mounted into the Jupyter container. Notebooks (and their
related files) should be saved in this directory.

Python modules can be used from Scala code via [ScalaPy](https://github.com/scalapy/scalapy). Every Python module should
be added to the `requirements.txt` file. Changes require running `docker-compose up --build -d` again (Almond doesn't
allow using `!pip ...` within notebooks). Remember to save everything before the restart.