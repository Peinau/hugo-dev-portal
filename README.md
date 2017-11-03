Build Image
=================

```sh
# build base image
docker build -t portal-documentation:1.0.1 .

#  run build image
docker run -p 1313:1313 --rm peinau.azurecr.io/portal-documentation:1.0.1
```

