# addok-docker

Docker stack for [addok](https://github.com/addok/addok), the search engine for address.

This repository contains the definition of a docker image and a docker docker stack using this image to deploy an `addok` instance.

Note: The published version uses the addresses from the Seine-Saint-Denis department published by [Etalab](https://www.etalab.gouv.fr/). 
Other data sources can be used by modifying the file [entrypoint.sh](https://github.com/ClementDelgrange/addok-docker/blob/155c580a586f6d2092320ec715a949f0a56beac2/entrypoint.sh#L29).

## Start the service
The service can be launched with `docker-compose`. In this case, only one replica will be deployed:
```bash
# Attached to the terminal
docker-composes up

# Or in the background
docker-composes up -d
```

By using `docker stack`, several replicas of the service can be deployed:
```bash
docker swarm init  # only the first time
docker stack deploy docker-stack.yml addok
```

Once deployed, the service is accessible via the URL: <http://localhost:7878/search?q={the address to geocode}>