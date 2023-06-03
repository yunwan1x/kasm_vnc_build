#!/usr/bin/env bash
### every exit != 0 fails the script
set -ex

ARCH=$(arch | sed 's/aarch64/arm64/g' | sed 's/x86_64/amd64/g')
echo "Install Audio Requirements"
if [[ "${DISTRO}" == @(centos|oracle7) ]] ; then
  yum install -y curl git
  yum install -y epel-release
  yum localinstall -y --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm
  yum install -y ffmpeg pulseaudio-utils
  yum remove -y pulseaudio-module-bluetooth
  DISTRO=centos
elif [ "${DISTRO}" == "oracle8" ]; then
  dnf install -y curl git
  dnf config-manager --set-enabled ol8_codeready_builder
  dnf localinstall -y --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm
  dnf install -y ffmpeg pulseaudio-utils
  dnf remove -y pulseaudio-module-bluetooth
  dnf clean all
  DISTRO=oracle
elif [ "${DISTRO}" == "opensuse" ]; then
  zypper install -ny curl git
  zypper install -yn ffmpeg pulseaudio-utils
  zypper clean --all
else
  apt-get update
  apt-get install -y curl git ffmpeg
fi

mkdir -p /var/run/pulse

