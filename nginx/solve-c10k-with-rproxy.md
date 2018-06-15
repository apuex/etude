# Solving C10k Problem with Nginx Reverse Proxy

Application server may not able to handle C10k problem.
Migrating applications from one application server to another maybe impossible.

This approach maybe a solution to your problem.
Nginx is fully capable of handling C10k problem. By excercising request/response buffering,
incoming connections is not passed to proxied server synchronously.
Instead, Nginx handle the connections, and proxied server handle requests,
which turns the C10k problem to throughtput problem.
as long as the proxied server is capable of handle the request/per second, 
it doesn't matter whether the application can handle C10k or not.

```
    location / {
        proxy_pass http://192.168.0.2:10080;

        proxy_buffering on;
        client_body_buffer_size 64k;
        proxy_buffer_size 64k;
        proxy_buffers 2048 64k;
        proxy_max_temp_file_size 0;
    }
```

