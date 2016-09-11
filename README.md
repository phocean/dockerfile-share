Debian based Samba share for quick and safe file sharing.

# Build

First, adjust the configuration file with the shares you wish to provide.

Then, build with setting your custom password for write permissions:

```
docker run -t phocean/share --build-arg WRITE_PASSWORD=mysecret123 .
```

# Run

Type:

```
docker run -d -p 445:445 phocean/share
```

Then you can access to the share with the credentials you set.
