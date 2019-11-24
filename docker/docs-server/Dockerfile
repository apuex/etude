FROM debian:9

RUN mkdir -p /app

COPY http-server-fast /app/

WORKDIR /app

CMD ["./http-server-fast", "0.0.0.0", "9080", "/htdocs", "100", "block"]


