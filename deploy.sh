eval $(docker-machine env docker-master-1)
docker build -t adrian_web .
docker stop adrian_web
docker rm adrian_web
docker run -d --rm --name adrian_web -p 3001:80 adrian_web
