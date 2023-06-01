# docker system prune
tag=20.04-base-v1
docker build -t kasmweb/core-ubuntu-focal:develop -f ./workspaces-core-images/dockerfile-kasm-ubuntu   ./workspaces-core-images \
&& docker build -t changhui/ubuntu:$tag  --progress plain -f ./workspaces-images/dockerfile-kasm-desktop ./workspaces-images \
&& docker push changhui/ubuntu:$tag
# exit 0
tag=20.04-ide-v1
docker build -t changhui/ubuntu:$tag -f ./workspaces-images/dockerfile-kasm-desktop-idea ./workspaces-images  \
&& docker push changhui/ubuntu:$tag


