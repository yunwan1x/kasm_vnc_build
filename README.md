# build,启用build kit

1. `DOCKER_BUILDKIT=1  docker build -t kasmweb/core-ubuntu-focal:develop -f /root/kasm_vnc/workspaces-core-images/dockerfile-kasm-ubuntu   /root/kasm_vnc/workspaces-core-images && docker build -t changhui/ubuntu:cuda-11.3  -f /root/kasm_vnc/workspaces-images/dockerfile-kasm-desktop /root/kasm_vnc/workspaces-image`

# run
1. docker run --rm -it --shm-size=512m --name ubuntu -p 6901:443  -e VNC_PW=password changhui/ubuntu:11.3
2. 可以挂载访问证书到${HOME}/.vnc/self.pem

# 安装中文字体
可以选择 苹果丽黑字体，微软雅黑字体
。


# 新立得软件包
apt-get install synaptic

# 开启代理
gost -L 127.0.0.1:7666 -F  sshd://user:password@ip:port

# 开启gpu加速
1. 去这里下载  https://rawcdn.githack.com/VirtualGL/virtualgl/3.0.2/doc/index.html
2. 文档 https://sourceforge.net/projects/virtualgl/files/
3. apt install --fix-broken  ./virtualgl.deb
4. export VGL_DISPLAY=/dev/dri/card2
5. chmod a+rw /dev/dri/renderD129
6. vglrun /opt/VirtualGL/bin/glxspheres64

# 使用fileserver
1. 命令行upload  `curl -k --user user:password  -v  -F "path=@$FILE" 'https://host:port/upload/upload?path=/'`

# 使用帮助
1. libQt5Core.so.5: cannot open shared object file: No such file or directory 。

  apt install binutils; strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5
