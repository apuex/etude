# Create self-signed key

```
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 3650
```

```
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -keyout example.key -out example.crt -extensions san -config \
  <(echo "[req]"; 
    echo distinguished_name=req; 
    echo "[san]"; 
    echo subjectAltName=DNS:example.com,DNS:example.net,IP:10.0.0.1
    ) \
  -subj /CN=example.com
```

for openssl > 1.1.1,

```
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -keyout example.key -out example.crt -subj /CN=example.com \
  -addext subjectAltName=DNS:example.com,DNS:example.net,IP:10.0.0.1
```

Here is a simplified version that removes the passphrase, ups the security to suppress warnings and includes a suggestion in comments to pass in -subj to remove the full question list:

```
openssl genrsa -out server.key 2048
openssl rsa -in server.key -out server.key
openssl req -sha256 -new -key server.key -out server.csr -subj '/CN=localhost'
openssl x509 -req -sha256 -days 365 -in server.csr -signkey server.key -out server.crt
```

Replace 'localhost' with whatever domain you require. You will need to run the first two commands one by one as OpenSSL will prompt for a passphrase.

To combine the two into a .pem file:

```
cat server.crt server.key > cert.pem
```

