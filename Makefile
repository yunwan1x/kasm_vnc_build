base_tag=20.04-base
ide_tag=20.04-ide
build: build-focal build-base build-ide
push: push-base push-ide
build-focal:
	docker build -t kasmweb/core-ubuntu-focal:develop -f ./workspaces-core-images/dockerfile-kasm-ubuntu   ./workspaces-core-images 
build-base:
	docker build -t changhui/ubuntu:$base_tag    -f ./workspaces-images/dockerfile-kasm-desktop ./workspaces-images 
push-base:
	docker push changhui/ubuntu:$base_tag

build-ide:
	docker build -t changhui/ubuntu:$ide_tag -f ./workspaces-images/dockerfile-kasm-desktop-idea ./workspaces-images  
push-ide:
	docker push changhui/ubuntu:$ide_tag