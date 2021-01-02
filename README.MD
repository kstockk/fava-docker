# fava-docker

beancount-fava in a docker container. (includes additional custom bean-price scripts)

## Quickstart

```
docker run -d \
           --name beancount-fava \
           -p 5000:5000 \
           -v /bean:/bean \
           -e BEANCOUNT_FILE=/bean/master.beancount \
           --restart always \
           lykhee/fava-docker 
```
