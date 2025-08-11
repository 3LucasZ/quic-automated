docker build -t quichecker . -f ./docker/Dockerfile 
docker run -it --rm --name bot1 --env-file ./docker/.env \
    --cap-add=NET_RAW --cap-add=NET_ADMIN quichecker