#!/usr/bin/env bash
set -e

echo "Install some common tools for further installation"
if [[ "${DISTRO}" == @(centos|oracle7) ]] ; then
  yum install -y vim wget net-tools bzip2 python3 ca-certificates
elif [ "${DISTRO}" == "oracle8" ]; then
  dnf install -y wget net-tools bzip2 python3 tar vim hostname
  dnf clean all
elif [ "${DISTRO}" == "opensuse" ]; then
  sed -i 's/download.opensuse.org/mirrorcache-us.opensuse.org/g' /etc/zypp/repos.d/*.repo
  zypper install -yn wget net-tools bzip2 python3 tar vim gzip iputils
  zypper clean --all
else
  apt-get update
  # Update tzdata noninteractive (otherwise our script is hung on user input later).
  DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
  apt-get install -y sudo openssh-server  vim wget tini tmux nginx  net-tools locales bzip2 wmctrl software-properties-common mesa-utils 
  apt-get clean -y

  echo "generate locales für en_US.UTF-8"
  locale-gen en_US.UTF-8
  wget -O /usr/local/bin/miniserve https://github.com/svenstaro/miniserve/releases/download/v0.24.0/miniserve-0.24.0-x86_64-unknown-linux-musl
  chmod +x /usr/local/bin/miniserve
fi

if [ "$DISTRO" = "ubuntu" ]; then
  #update mesa to latest
  add-apt-repository ppa:kisak/turtle
  apt full-upgrade -y
fi
