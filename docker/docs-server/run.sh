docker build . --tag docs-server:1.0.0
docker run -d --name boost-docs -v $HOME/github:/htdocs -p 9080:9080 docs-server:1.0.0

