ARG PYTHON_VERSION=3.12
FROM python:${PYTHON_VERSION}-slim

# Install JupyterLab
RUN pip install jupyterlab

# Install Java Runtime and other utils
ARG JRE_VERSION=17
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      openjdk-${JRE_VERSION}-jre-headless \
      curl \
      unzip \
      && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Almond kernel with Scala
ARG ALMOND_VERSION=0.14.0-RC15
ARG SCALA_VERSION=2.13.14
RUN curl -Lo coursier https://git.io/coursier-cli && \
    chmod +x coursier && \
    ./coursier launch almond:${ALMOND_VERSION} --scala ${SCALA_VERSION} -- \
      --install --display-name "Scala ${SCALA_VERSION}" && \
    rm -f coursier

WORKDIR /workspace

# Start JupyterLab (note: allow-root is unsafe, don't use it in production)
EXPOSE 8888
CMD ["jupyter", "lab", "--allow-root", "--ip=0.0.0.0"]