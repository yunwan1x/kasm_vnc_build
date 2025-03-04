
#  dive can be found here https://github.com/wagoodman/dive
ARCH := $(shell uname -p)

# 根据不同架构设置不同的build_tag
ifeq ($(ARCH),aarch64)
    base_tag := 20.04_aarch64
else
    base_tag := 20.04
endif


idea=20.04-idea
clion=20.04-clion
copy:
	docker cp ubuntu-desktop:/home/kasm-user/Desktop/puppeteer/ /root/changhui/poc/kasm_vnc_build/workspaces-images/src/ubuntu/install/puppeteer
build: build-focal build-base build-idea build-clion
push: push-base push-idea push-clion
build-focal:
	docker build -t kasmweb/core-ubuntu-focal:develop -f ./workspaces-core-images/dockerfile-kasm-ubuntu   ./workspaces-core-images 
build-base: build-focal
	docker login --username=mpaas_aliyun_pre@1425475265144594 registry.cn-hangzhou.aliyuncs.com --password abcABC@123
	docker login --username=changhui  --password wy3426231987
	docker build -t changhui/ubuntu:${base_tag}    --progress=plain  -f ./workspaces-images/dockerfile-kasm-desktop ./workspaces-images 
	docker tag changhui/ubuntu:${base_tag} registry.cn-hangzhou.aliyuncs.com/mpaas-public/ubuntu:${base_tag} 
	docker push registry.cn-hangzhou.aliyuncs.com/mpaas-public/ubuntu:${base_tag}
	docker push changhui/ubuntu:${base_tag}
push-base:
	docker push changhui/ubuntu:${base_tag}

commit:
	git add .;git commit -am 'add' ; git push



build-idea:
	docker build -t changhui/ubuntu:${idea} -f ./workspaces-images/dockerfile-kasm-desktop-idea ./workspaces-images  
push-idea:
	docker push changhui/ubuntu:${idea}

build-clion:
	docker build -t changhui/ubuntu:${clion} -f ./workspaces-images/dockerfile-kasm-desktop-clion ./workspaces-images  
push-clion:
	docker push changhui/ubuntu:${clion}
run:
	docker run  -it -d  --privileged  --shm-size=512m -e DOMAIN_NAME=mydomain.com -e IP1=10.10.10.1  --name ubuntu -p 2222:22 -p 6901:443  -e USER_NAME=kasm-user -e VNC_PW=password -v /root/changhui/poc:/home/kasm-user/Desktop/poc  changhui/ubuntu:${idea}	
run-test:
	docker rm -f ubuntu1 ; docker run  -it   --privileged  --shm-size=512m -e DOMAIN_NAME=mydomain.com -e IP1=10 .10.10.1  -e DEBUG=true --name ubuntu1 -p 2232:22 -p 6902:443  -e USER_NAME=kasm-user -e VNC_PW=password changhui/ubuntu:${idea}


## vscode-server
build-vscode-server:
	docker build --progress plain  -t changhui/vscode-server -f ./workspaces-images/dockerfile-kasm-vscode-server   ./workspaces-images 
push-vscode-server:	
	docker push  changhui/vscode-server
run-vscode-server:
	docker run --rm --name  vscode -p 6905:443 changhui/vscode-server
run-desktop:
	docker rm -f vscodedesktop ;rm -rf /tmp/kasm;mkdir /tmp/kasm; docker run    --shm-size=512m --rm   -e IP1=47.242.184.174   -e DEBUG=true -e USER_NAME=admin -e VNC_PW=admin  -e DOMAIN_NAME=wy.aliyuncs.com -v /tmp/kasm:/home/kasm-user  --name  vscodedesktop -p 6905:443 -p 6906:80 changhui/ubuntu:${base_tag} \
		

# slim:
# 	docker-slim build  --http-probe=false   --target  changhui/ubuntu:20.04-idea