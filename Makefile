base_tag=20.04-base
ide_tag=20.04-ide
ide_tag_only=20.04-ide-only
build: build-focal build-base build-ide build-ide-only
push: push-base push-ide push-ide-only
build-focal:
	docker build -t kasmweb/core-ubuntu-focal:develop -f ./workspaces-core-images/dockerfile-kasm-ubuntu   ./workspaces-core-images 
build-base:
	docker build -t changhui/ubuntu:${base_tag}    -f ./workspaces-images/dockerfile-kasm-desktop ./workspaces-images 
push-base:
	docker push changhui/ubuntu:${base_tag}

commit:
	git commit -am 'add' ; git push
build-ide:
	docker build -t changhui/ubuntu:${ide_tag} -f ./workspaces-images/dockerfile-kasm-desktop-idea ./workspaces-images  
push-ide:
	docker push changhui/ubuntu:${ide_tag}

build-ide-only:
	docker build -t changhui/ubuntu:${ide_tag_only} -f ./workspaces-images/dockerfile-kasm-desktop-idea-only ./workspaces-images  
push-ide-only:
	docker push changhui/ubuntu:${ide_tag_only}
run:
	docker run  -it -d  --privileged  --shm-size=512m -e DOMAIN_NAME=mydomain.com -e IP1=10.10.10.1  --name ubuntu -p 2222:22 -p 6901:443  -e USER_NAME=kasm-user -e VNC_PW=password changhui/ubuntu:${ide_tag}	
run-test:
	docker run  -it --rm  --privileged  --shm-size=512m -e DOMAIN_NAME=mydomain.com -e IP1=10.10.10.1  -e DEBUG=true --name ubuntu1 -p 2232:22 -p 6902:443  -e USER_NAME=kasm-user -e VNC_PW=password changhui/ubuntu:${ide_tag_only}


## vscode-server
build-vscode-server:
	docker build -t changhui/vscode-server -f ./workspaces-images/dockerfile-kasm-vscode-server   ./workspaces-images 