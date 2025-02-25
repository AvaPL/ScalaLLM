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

#### Installing Python modules

Python modules can be installed from within a notebook using:

```scala
import $file.Magic // when in the same folder as Magic.sc
// import $file.^.Magic // when Magic.sc is in the parent folder

Magic.!("pip", "install", "torch==2.5.*")
```

Python modules can be used from Scala code via [ScalaPy](https://github.com/scalapy/scalapy):

```scala
import $ivy.`dev.scalapy::scalapy-core:0.5.3`
import me.shadaj.scalapy.py

val torch = py.module("torch")
```

#### Rendering text and images

Examples for renedring text (Markdown, HTML and LaTeX), check the
examples [here](https://github.com/almond-sh/almond/blob/v0.14.0-RC15/examples/displays.ipynb).

If you want to use matplotlib, there's a small util in `DisplaySupport.sc`, which you can use like this:

```scala
import $file.DisplaySupport // when in the same folder as DisplaySupport.sc
// import $file.^.DisplaySupport // when DisplaySupport.sc is in the parent folder

val plot = py.module("matplotlib.pyplot")
// setup the plot here...
DisplaySupport.showPlot(plot)
```