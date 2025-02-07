# 功能列表（20241024）

1.  集成了navi命令行，NAVI_PATH="\$HOME/Uploads/cheat:/usr/share/cheat"

2.  CA签署证书指令

    ``` bash
    DIR=/tmp
    DOMAIN_NAME=vs2010wy.top
    IP1=127.0.0.1
    IP2=127.0.0.2
    cat <<EOF > ${DIR}/certificate.cfg
    authorityKeyIdentifier=keyid,issuer
    basicConstraints=CA:FALSE
    keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
    subjectAltName = @alt_names

    [alt_names]
    DNS.1 = ${DOMAIN_NAME}
    DNS.2 = *.${DOMAIN_NAME}
    IP.1 = ${IP1}
    IP.2 = ${IP2}
    EOF

    cat <<EOF > ${DIR}/server.cnf
    [req]
    default_bits = 2048
    prompt = no
    default_md = sha256
    req_extensions = req_ext
    distinguished_name = dn

    [dn]
    C = CN
    ST = YourState
    L = YourCity
    O = YourOrganization
    OU = YourUnit
    CN = ${DOMAIN_NAME-mydomain.com}   

    [req_ext]
    subjectAltName = @alt_names

    [alt_names]
    DNS.1 = ${DOMAIN_NAME-mydomain.com}
    DNS.2 = *.${DOMAIN_NAME-mydomain.com}  
    DNS.3 = localhost  
    IP.1 = ${IP1}  
    IP.2 = ${IP2}
    EOF

    openssl genrsa -out ${DIR}/self.key 2048
    openssl req -new -sha256 -key ${DIR}/self.key -config ${DIR}/server.cnf -out server.csr 
    openssl x509 -req -in server.csr -CA /usr/share/cert/ca.crt -CAkey /usr/share/cert/ca.key -CAcreateserial -out ${DIR}/self.crt -days 3650 -sha256 -extfile ${DIR}/certificate.cfg 
    rm server.csr
    cat ${DIR}/self.crt ${DIR}/self.key > ${DIR}/self.pem
    ```

3.  各系统安装证书

    ``` bash
    # macos
    sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ca.crt
    sudo security delete-certificate -c ""

    # ubuntu,alpine,debian
    sudo cp ca.crt /usr/local/share/ca-certificates
    sudo update-ca-certificates

    # centos
    sudo cp ca.crt  /etc/ssl/certs/ca.crt
    sudo update-ca-trust
    ```

4.  运行本镜像

    ``` bash
    docker run --rm --shm-size=512m -v HOSTPATH:/home/kasm-user/  -e DEBUG=true -e USER_NAME=admin -e VNC_PW=admin  -e DOMAIN_NAME=wy.aliyuncs.com -e IP1=xx.xx.xx.xx  --name -p 6906:80  vscodedesktop -p 6905:443 changhui/ubuntu:20.04
    ```

5.  集成了drawio

6.  集成了excel编辑器

7.  集成了sample.http功能

8.  集成了quarto 文档写作工具。参考 [galleray](https://quarto.org/docs/gallery/)

9.  集成了[rclone](https://rclone.org/docs/), [k9s](https://github.com/derailed/k9s)

    ``` bash

     # gui模式
    rclone rcd  --rc-pass admin  --rc-user admin --rc-web-gui  --rc-serve --rc-addr :5572
    rclone rcd  --rc-no-auth --rc-web-gui --rc-serve --rc-addr :5572 
    # shell 模式
    rclone config - Enter an interactive configuration session.
    rclone copy - Copy files from source to dest, skipping already copied.
    rclone sync - Make source and dest identical, modifying destination only.
    rclone bisync - Bidirectional synchronization between two paths.
    rclone move - Move files from source to dest.
    rclone delete - Remove the contents of path.
    rclone purge - Remove the path and all of its contents.
    rclone mkdir - Make the path if it doesn't already exist.
    rclone rmdir - Remove the path.
    rclone rmdirs - Remove any empty directories under the path.
    rclone check - Check if the files in the source and destination match.
    rclone ls - List all the objects in the path with size and path.
    rclone lsd - List all directories/containers/buckets in the path.
    rclone lsl - List all the objects in the path with size, modification time and path.
    rclone md5sum - Produce an md5sum file for all the objects in the path.
    rclone sha1sum - Produce a sha1sum file for all the objects in the path.
    rclone size - Return the total size and number of objects in remote:path.
    rclone version - Show the version number.
    rclone cleanup - Clean up the remote if possible.
    rclone dedupe - Interactively find duplicate files and delete/rename them.
    rclone authorize - Remote authorization.
    rclone cat - Concatenate any files and send them to stdout.
    rclone copyto - Copy files from source to dest, skipping already copied.
    rclone completion - Output shell completion scripts for rclone.
    rclone gendocs - Output markdown docs for rclone to the directory supplied.
    rclone listremotes - List all the remotes in the config file.
    rclone mount - Mount the remote as a mountpoint.
    rclone moveto - Move file or directory from source to dest.
    rclone obscure - Obscure password for use in the rclone.conf
    rclone cryptcheck - Check the integrity of an encrypted remote.
    rclone about - Get quota information from the remote.
    ```

# rclone使用

rclone的配置文件在 \~/.config/rclone/rclone.conf。rclone config 添加配置。mount远程文件系统到本地

``` bash
# 简单挂载
rclone mount ssh-remote:/root  ./changhui

#一条完整的Rclone挂载命令
rclone mount ssh-remote:/file /data/wwwroot/xxx --allow-other --attr-timeout 5m --vfs-cache-mode full --vfs-cache-max-age 24h --vfs-cache-max-size 10G --vfs-read-chunk-size-limit 100M --buffer-size 100M --daemon
# 强制卸载
fusermount3 -zu ./changhui 
# 不行再用
sudo umount -f ./changhui
# tui方式查看
rclone  ncdu ssh-remote:/root

# webui方式
rclone rcd  --rc-no-auth --rc-web-gui --rc-serve --rc-addr :5572 
```

# 使用k9s

1.  sudo k9s ，由于kubectl版本问题，所以需要sudo ，不然shell in pod 会有问题

2.  可以配置shell in node。 shell镜像配置在/root/.config/k9s/config.yaml里，然后到/root/.local/share/k9s/clusters里配置门控开关。

3.  可以设置皮肤

4.  可以设置keys, keys位置在

    ``` yaml
    hotKeys:

    # Hitting Shift-0 navigates to your pod view matching pods with labels app=kindnet
    shift-0:
      shortCut:    Shift-0
      description: Viewing pods
      command:     pods app=kindnet

    # Hitting Shift-1 navigates to your deployments
    shift-1:
      shortCut:    Shift-1
      description: View deployments
      command:     dp

    # Hitting Shift-2 navigates to your xray deployments
    shift-2:
      shortCut:    Shift-2
      description: XRay Deployments
      command:     xray deploy
    ```

5.  net debug tool镜像 <https://github.com/nicolaka/netshoot> , 集成了常用的网络相关调试工具。

# 安装的vscode插件

| 序号 | 插件名称                     | 用处             |
|------|------------------------------|------------------|
| 1    | rangav.vscode-thunder-client |                  |
| 2    | johnpapa.vscode-peacock      |                  |
| 3    | moshfeu.compare-folders      |                  |
| 4    | xyz.local-history            | 本地历史         |
| 5    | quarto.quarto                |                  |
| 6    | hediet.vscode-drawio         |                  |
| 7    | alefragnani.project-manager  |                  |
| 8    | ryu1kn.partial-diff          | 部分比较         |
| 9    | huizhou.githd                | git view history |
| 10   | snippetsmanager              | 代码片段管理       |
|      |                              |                  |
|      |                              |                  |