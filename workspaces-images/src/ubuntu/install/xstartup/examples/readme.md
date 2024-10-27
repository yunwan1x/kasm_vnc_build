# 功能列表（20241024）

1. 集成了navi命令行，NAVI_PATH="$HOME/Uploads/cheat:/usr/share/cheat"
2. CA文件在/usr/share/cert/
3. 运行本镜像 `docker run --rm --shm-size=512m -v HOSTPATH:/home/kasm-user/  -e DEBUG=true -e USER_NAME=admin -e VNC_PW=admin  -e DOMAIN_NAME=wy.aliyuncs.com  --name  vscodedesktop -p 6905:443 changhui/ubuntu:20.04-base`
4. 集成了drawio
5. 集成了excel编辑器
6. 集成了sample.http功能
7. 集成了quarto 文档写作工具。参考 [galleray](https://quarto.org/docs/gallery/)
