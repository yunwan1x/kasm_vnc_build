# docker system prune
tag=20.04-base
docker build -t kasmweb/core-ubuntu-focal:develop -f ./workspaces-core-images/dockerfile-kasm-ubuntu   ./workspaces-core-images
docker build -t changhui/ubuntu:$tag -f ./workspaces-images/dockerfile-kasm-desktop ./workspaces-images

#exit 0
docker push changhui/ubuntu:$tag
tag=20.04-ide
docker build -t kasmweb/core-ubuntu-focal:develop -f ./workspaces-core-images/dockerfile-kasm-ubuntu   ./workspaces-core-images
docker build -t changhui/ubuntu:$tag -f ./workspaces-images/dockerfile-kasm-desktop-idea ./workspaces-images && docker push changhui/ubuntu:$tag


