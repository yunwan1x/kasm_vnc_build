
#  dive can be found here https://github.com/wagoodman/dive
base_tag=20.04-base
idea=20.04-idea
clion=20.04-clion
copy:
	docker cp ubuntu-desktop:/home/kasm-user/Desktop/puppeteer/ /root/changhui/poc/kasm_vnc_build/workspaces-images/src/ubuntu/install/puppeteer
build: build-focal build-base build-idea build-clion
push: push-base push-idea push-clion
build-focal:
	docker build -t kasmweb/core-ubuntu-focal:develop -f ./workspaces-core-images/dockerfile-kasm-ubuntu   ./workspaces-core-images 
build-base:
	docker build -t changhui/ubuntu:${base_tag}    -f ./workspaces-images/dockerfile-kasm-desktop ./workspaces-images 
	docker tag changhui/ubuntu:${base_tag} registry.cn-hangzhou.aliyuncs.com/mpaas-public/ubuntu:20.04 
	docker push registry.cn-hangzhou.aliyuncs.com/mpaas-public/ubuntu:20.04
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
	docker rm -f ubuntu1 ; docker run  -it   --privileged  --shm-size=512m -e DOMAIN_NAME=mydomain.com -e IP1=10.10.10.1  -e DEBUG=true --name ubuntu1 -p 2232:22 -p 6902:443  -e USER_NAME=kasm-user -e VNC_PW=password changhui/ubuntu:${idea}


## vscode-server
build-vscode-server:
	docker build --progress plain  -t changhui/vscode-server -f ./workspaces-images/dockerfile-kasm-vscode-server   ./workspaces-images 
push-vscode-server:	
	docker push  changhui/vscode-server
run-vscode-server:
	docker run --rm --name  vscode -p 6905:443 changhui/vscode-server
run-desktop:
	docker rm -f vscodedesktop ;docker run    --shm-size=512m --rm -e DEBUG=true -e USER_NAME=admin -e VNC_PW=admin  -e DOMAIN_NAME=wy.aliyuncs.com  --name  vscodedesktop -p 6905:443 -p 6906:80 changhui/ubuntu:20.04-base \
		

# slim:
# 	docker-slim build  --http-probe=false   --target  changhui/ubuntu:20.04-idea