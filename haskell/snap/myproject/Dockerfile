FROM ubuntu:latest

RUN echo "tcp 6 TCP # transmission control protocol" > /etc/protocols

VOLUME /tmp
VOLUME /log

COPY dist/build/myproject /app

CMD ["/app/myproject"]
EXPOSE 8000
