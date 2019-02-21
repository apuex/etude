FROM ubuntu:latest

RUN echo "tcp 6 TCP # transmission control protocol" > /etc/protocols

VOLUME /tmp

COPY dist/build/hello-happstack /app

CMD ["/app/hello-happstack"]
EXPOSE 8000
