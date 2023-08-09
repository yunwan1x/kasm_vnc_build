# 发布说明

1. 20.04-base 包含vscode-web, chrome . 20.04-ide 增加idea pro 2022.4 ,clion 2022.4

# build,启用build kit

1. `DOCKER_BUILDKIT=1  bash build.sh`

# run

1. 启动命令

```shell
docker run  -it -d  --restart always --shm-size=512m --name ubuntu -p 6901:443 --hostname=mycomputer --privileged -e IP1=10.10.10.1 -e DOMAIN_NAME=mydomain.com   -e USER_NAME=kasm-user -e VNC_PW=password changhui/ubuntu:20.04-ide
```

3. ip1和domain_name是自签证书的subjectaltname。
4. ca证书放在~/Uploads下面，可加入本地信任证书位置
5. 可以挂载访问证书到${HOME}/.vnc/self.pem
6. 调试

# 开启代理

gost -L 127.0.0.1:7666 -F  sshd://user:password@ip:port

# 开启sshserver

dropbear 是静态编译的

mkdir -p /etc/dropbear

/usr/local/bin/dropbearkey  -t ecdsa -f /etc/dropbear/dropbear_ecdsa_host_key

/usr/local/bin/dropbear -E -p 2111

# 开启gpu加速

1. 去这里下载  https://rawcdn.githack.com/VirtualGL/virtualgl/3.0.2/doc/index.html
2. 文档 https://sourceforge.net/projects/virtualgl/files/
3. apt install --fix-broken  ./virtualgl.deb
4. export VGL_DISPLAY=/dev/dri/card2
5. chmod a+rw /dev/dri/renderD129
6. vglrun /opt/VirtualGL/bin/glxspheres64

# 使用帮助

1. libQt5Core.so.5: cannot open shared object file: No such file or directory 。
   * apt install binutils; strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5
2. apt install xmodmap，修改按键映射，比如中键切换到右键，实现terminal右键粘贴。[linux下输入映射](https://www.cnblogs.com/yinheyi/p/10146900.html)
3. chrome 以app模式运行  chrome --app url
4. 如何解决IntelliJ IDEA一直弹出Server‘s certificate is not trusted 弹窗？
   1. file->settings 搜索【Server Certificates】 ,取消勾选 Accept non-trusted certificates automatically
5. 如果xfce4复制粘贴不好使用, 可以关掉剪切板权限
6. Unlock Login Keyring时忘记密码解决办法：
   rm -rf ~/.gnome2/keyrings/defaults.keyring
