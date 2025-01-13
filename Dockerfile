ARG PYTHON_VERSION=3.12
FROM python:${PYTHON_VERSION}-slim

# Install curl and Java
ARG OPENJDK_VERSION=17
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl openjdk-${OPENJDK_VERSION}-jdk && \
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

# Install JupyterLab
RUN pip install jupyterlab

WORKDIR /workspace

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && \
    rm -f requirements.txt

# Start JupyterLab (note: allow-root is unsafe, don't use it in production)
EXPOSE 8888
CMD ["jupyter", "lab", "--allow-root", "--ip=0.0.0.0"]