FROM python:3.11-slim

COPY *.cer /usr/local/share/ca-certificates/

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install mitmproxy AND append the gov cert to Python's certifi bundle
RUN pip install --no-cache-dir mitmproxy

EXPOSE 8080
CMD ["mitmdump", "--listen-host", "0.0.0.0", "--listen-port", "8080", "--ssl-insecure"]
