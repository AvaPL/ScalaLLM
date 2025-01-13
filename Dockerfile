FROM python:3.12-slim

WORKDIR /app

# Install curl and Java 17
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl openjdk-17-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Almond kernel with Scala 3.3
RUN curl -Lo coursier https://git.io/coursier-cli && \
    chmod +x coursier && \
    ./coursier launch almond:0.14.0-RC15 --scala 3.3.3 -- --install && \
    rm -f coursier

# Install JupyterLab
RUN pip install jupyterlab

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Start JupyterLab (note: allow-root is unsafe, don't use it in production)
EXPOSE 8888
CMD ["jupyter", "lab", "--allow-root", "--ip=0.0.0.0"]