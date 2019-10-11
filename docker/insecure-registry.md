# Insecure Registry Settings

## add insecure registry to docker client

```
sudo cat > /et/docker/daemon.json
{ "insecure-registries":["113.108.158.19:5000"]}
^D
```

restart docker daemon:

```
systemctl restart docker
```

## login to insecure registry

```
docker login 113.108.158.19:5000
````

## push to insecure registry

```
docker image tag doc-server:1.0.0 113.108.158.19:5000/doc-server:1.0.0
docker push 113.108.158.19:5000/doc-server:1.0.0
```

## pull from insecure registry

```
docker pull 113.108.158.19:5000/doc-server:1.0.0
```
