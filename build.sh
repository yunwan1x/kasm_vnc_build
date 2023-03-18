# docker system prune
#tag=20.04-base
#docker build -t kasmweb/core-ubuntu-focal:develop -f /root/kasm_vnc/workspaces-core-images/dockerfile-kasm-ubuntu   /root/kasm_vnc/workspaces-core-images && docker build -t changhui/ubuntu:$tag -f /root/kasm_vnc/workspaces-images/dockerfile-kasm-desktop /root/kasm_vnc/workspaces-images && docker push changhui/ubuntu:$tag
#exit 0
tag=20.04-ide
docker build -t kasmweb/core-ubuntu-focal:develop -f /root/kasm_vnc/workspaces-core-images/dockerfile-kasm-ubuntu   /root/kasm_vnc/workspaces-core-images && docker build -t changhui/ubuntu:$tag -f /root/kasm_vnc/workspaces-images/dockerfile-kasm-desktop-idea /root/kasm_vnc/workspaces-images && docker push changhui/ubuntu:$tag


echo build finish  `date` >>/root/build.txt
