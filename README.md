# build,启用build kit

1. DOCKER_BUILDKIT=1  docker build -t kasmweb/core-ubuntu-focal:develop -f /root/kasm_vnc/workspaces-core-images/dockerfile-kasm-ubuntu   /root/kasm_vnc/workspaces-core-images && docker build -t changhui/ubuntu:cuda-11.3  -f /root/kasm_vnc/workspaces-images/dockerfile-kasm-desktop /root/kasm_vnc/workspaces-image

# run
 docker run --rm -it --shm-size=512m --name ubuntu -p 6901:443  -e VNC_PW=password changhui/ubuntu:11.3

# 安装中文字体
可以选择 苹果丽黑字体，微软雅黑字体
。


# 新立得软件包
apt-get install synaptic

# 开启代理
gost -L 127.0.0.1:7666 -F  sshd://user:password@ip:port
