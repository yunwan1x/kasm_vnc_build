# build,启用build kit

1. DOCKER_BUILDKIT=1  docker build -t kasmweb/core-ubuntu-focal:develop -f /root/kasm_vnc/workspaces-core-images/dockerfile-kasm-ubuntu   /root/kasm_vnc/workspaces-core-images && docker build -t changhui/ubuntu:cuda-11.3  -f /root/kasm_vnc/workspaces-images/dockerfile-kasm-desktop /root/kasm_vnc/workspaces-image

# run
 docker run --rm -it --shm-size=512m --name ubuntu -p 6901:443 -p 8080:8080 -e VNC_PW=password changhui/ubuntu:2.0

# 安装中文字体
可以选择 苹果丽黑字体，微软雅黑字体
。

# 修改style.css,连接按钮始终可见
echo '#noVNC_connect_button {display:block !important}' >>/usr/share/kasmvnc/www/dist/style.bundle.css

# 新立得软件包
apt-get install synaptic
