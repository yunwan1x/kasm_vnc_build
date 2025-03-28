#!/bin/bash
### every exit != 0 fails the script
set -ex
rm -rf $HOME/jsmpeg
no_proxy="localhost,127.0.0.1"
sudo sysctl -w fs.inotify.max_user_watches="524288"
sudo sed -i 's/#Port 22/Port 58022/' /etc/ssh/sshd_config && sudo  service ssh start 

# dict to store processes
declare -A KASM_PROCS
# export PATH=/usr/share/vscode-server-linux-x64-web:$PATH
export NAVI_PATH="$HOME/Uploads/cheat:/usr/share/cheat"

# switch passwords to local variables
tmpval=$VNC_VIEW_ONLY_PW
unset VNC_VIEW_ONLY_PW
VNC_VIEW_ONLY_PW=$tmpval
DOMAIN_NAME=${DOMAIN_NAME-mydomain.com}
tmpval=$VNC_PW
echo "root:$VNC_PW"|sudo chpasswd
unset VNC_PW
VNC_PW=$tmpval
BUILD_ARCH=$(uname -p)

# 删除chrome的用户锁文件
sudo rm -rf $HOME/.config/google-chrome/Singleton*
sudo rm -rf $HOME/.config/chromium/Singleton*
sudo chmod +x $HOME/Desktop/*.desktop



cat << EOF >>$HOME/.bashrc
export PATH=$PATH:$HOME/.local/bin
source /etc/profile.d/bash_completion.sh 
source <(kubectl completion bash)
source <(helm completion bash) 
EOF

cat << EOF >>$HOME/.zshrc
export PATH=$PATH:$HOME/.local/bin
source /etc/profile.d/bash_completion.sh 
source <(kubectl completion zsh)
source <(helm completion zsh) 
EOF


## end

STARTUP_COMPLETE=0
# 开启debug方式
# sed -i 's/^Exec.*/Exec=\/usr\/bin\/google-chrome --remote-debugging-port=9222 %U/' /home/kasm-user/Desktop/google-chrome.desktop
######## FUNCTION DECLARATIONS ##########

## print out help
function help (){
	echo "
		USAGE:

		OPTIONS:
		-w, --wait      (default) keeps the UI and the vncserver up until SIGINT or SIGTERM will received
		-s, --skip      skip the vnc startup and just execute the assigned command.
		                example: docker run kasmweb/core --skip bash
		-d, --debug     enables more detailed startup output
		                e.g. 'docker run kasmweb/core --debug bash'
		-h, --help      print out this help

		Fore more information see: https://github.com/ConSol/docker-headless-vnc-container
		"
}

## correct forwarding of shutdown signal
function cleanup () {
    sudo kill -s SIGTERM $!
    exit 0
}

function start_kasmvnc (){
	if [[ $DEBUG == true ]]; then
	  echo -e "\n------------------ Start KasmVNC Server ------------------------"
	fi

	DISPLAY_NUM=$(echo $DISPLAY | grep -Po ':\d+')
	# disable display auth
	

	if [[ $STARTUP_COMPLETE == 0 ]]; then
	    vncserver -kill $DISPLAY &> $STARTUPDIR/vnc_startup.log \
	    || rm -rfv /tmp/.X*-lock /tmp/.X11-unix &> $STARTUPDIR/vnc_startup.log \
	    || echo "no locks present"
	fi

    rm -rf $HOME/.vnc/*.pid

		VNCOPTIONS="$VNCOPTIONS -select-de manual"
    if [[ "${BUILD_ARCH}" =~ ^aarch64$ ]] && [[ -f /lib/aarch64-linux-gnu/libgcc_s.so.1 ]] ; then
		LD_PRELOAD=/lib/aarch64-linux-gnu/libgcc_s.so.1 vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION -websocketPort $NO_VNC_PORT -httpd ${KASM_VNC_PATH}/www -sslOnly -FrameRate=$MAX_FRAME_RATE -interface 127.0.0.1 -BlacklistThreshold=0 -FreeKeyMappings $VNCOPTIONS $KASM_SVC_SEND_CUT_TEXT $KASM_SVC_ACCEPT_CUT_TEXT
	else
		vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION -websocketPort $NO_VNC_PORT -httpd ${KASM_VNC_PATH}/www -sslOnly -FrameRate=$MAX_FRAME_RATE -interface 127.0.0.1 -BlacklistThreshold=0 -FreeKeyMappings $VNCOPTIONS $KASM_SVC_SEND_CUT_TEXT $KASM_SVC_ACCEPT_CUT_TEXT -Log *:stdout:0 
	fi

	KASM_PROCS['kasmvnc']=$(cat $HOME/.vnc/*${DISPLAY_NUM}.pid)

	if [[ $DEBUG == true ]]; then
	  echo -e "\n------------------ Started Websockify  ----------------------------"
	  echo "Websockify PID: ${KASM_PROCS['kasmvnc']}";
	fi
}

function start_window_manager (){
	echo -e "\n------------------ Xfce4 window manager startup------------------"

	if [ "${START_XFCE4}" == "1" ] ; then
		if [ -f /opt/VirtualGL/bin/vglrun ] && [ ! -z "${KASM_EGL_CARD}" ] && [ ! -z "${KASM_RENDERD}" ] && [ -O "${KASM_RENDERD}" ] && [ -O "${KASM_EGL_CARD}" ] ; then
		echo "Starting XFCE with VirtualGL using EGL device ${KASM_EGL_CARD}"
			DISPLAY=:1 /opt/VirtualGL/bin/vglrun -d "${KASM_EGL_CARD}" /usr/bin/startxfce4 --replace  &
		else    
			echo "Starting XFCE"
			if [ -f '/usr/bin/zypper' ]; then
	                DISPLAY=:1 /usr/bin/dbus-launch /usr/bin/startxfce4 --replace &>/dev/null &
		        else
																/usr/bin/startxfce4 --replace  &
															     fi
		
		fi
		KASM_PROCS['window_manager']=$!
	else
		echo "Skipping XFCE Startup"
	fi
}

function start_audio_out_websocket (){
	if [[ ${KASM_SVC_AUDIO:-1} == 1 ]]; then
		echo 'Starting audio websocket server'
		/usr/lib/code-server/lib/node /usr/share/jsmpeg/websocket-relay.js   kasmaudio 58081 54901    &
		KASM_PROCS['kasm_audio_out_websocket']=$!
		if [[ $DEBUG == true ]]; then
		  echo -e "\n------------------ Started Audio Out Websocket  ----------------------------"
		  echo "Kasm Audio Out Websocket PID: ${KASM_PROCS['kasm_audio_out_websocket']}";
		fi
	fi
}



function start_audio_out (){
	if [[ ${KASM_SVC_AUDIO:-1} == 1 ]]; then
		echo 'Starting audio server'

        if [ "${START_PULSEAUDIO:-0}" == "1" ] ;
        then
            echo "Starting Pulse"
            HOME=/var/run/pulse pulseaudio --start
        fi

		if [[ $DEBUG == true ]]; then
			echo 'Starting audio service in debug mode'
			HOME=/var/run/pulse no_proxy=127.0.0.1 ffmpeg -f pulse -fragment_size ${PULSEAUDIO_FRAGMENT_SIZE:-2000} -ar 44100 -i default -f mpegts -correct_ts_overflow 0 -codec:a mp2 -b:a 128k -ac 1 -muxdelay 0.001 http://127.0.0.1:58081/kasmaudio &>/dev/null  &
			KASM_PROCS['kasm_audio_out']=$!
		else
			echo 'Starting audio service'
			HOME=/var/run/pulse no_proxy=127.0.0.1 ffmpeg -v verbose -f pulse -fragment_size ${PULSEAUDIO_FRAGMENT_SIZE:-2000} -ar 44100 -i default -f mpegts -correct_ts_overflow 0 -codec:a mp2 -b:a 128k -ac 1 -muxdelay 0.001 http://127.0.0.1:58081/kasmaudio  &>/dev/null &
			KASM_PROCS['kasm_audio_out']=$!
			echo -e "\n------------------ Started Audio Out  ----------------------------"
			echo "Kasm Audio Out PID: ${KASM_PROCS['kasm_audio_out']}";
		fi
	fi
}

function start_upload (){
    miniserve -p 58080 -o -u -W -q    --route-prefix  upload   $HOME/Desktop/Uploads &
    KASM_PROCS['upload_server']=$!

}

function start_nginx (){

  sudo nginx -g "daemon off;" &
  KASM_PROCS['nginx']=$!
}

function start_vscode() {
    code-server  --abs-proxy-base-path /vscode /home/kasm-user/Desktop/Uploads/ --port 58000 --host 127.0.0.1 --auth none  &
    KASM_PROCS['vscode']=$!
}

function custom_startup (){
    custom_startup_script=/dockerstartup/custom_startup.sh
    if [ -f "$custom_startup_script" ]; then
      if [ ! -x "$custom_startup_script" ]; then
        echo "${custom_startup_script}: not executable, exiting"
        exit 1
      fi

      sudo 	"$custom_startup_script" &
      KASM_PROCS['custom']=$!
	fi
}

############ END FUNCTION DECLARATIONS ###########

if [[ $1 =~ "-h|--help" ]]; then
    help
    exit 0
fi

# should also source $STARTUPDIR/generate_container_user
if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi

if [[ ${KASM_DEBUG:-0} == 1 ]]; then
    echo -e "\n\n------------------ DEBUG KASM STARTUP -----------------"
    export DEBUG=true
    set -x
fi

trap cleanup SIGINT SIGTERM


# Create cert for KasmVNC
mkdir -p ${HOME}/.vnc
IP1=${IP1-10.10.10.1}
IP2=${IP2-10.10.10.254}
IP3=${IP3-127.0.0.1}
cat <<EOF > ${HOME}/.vnc/certificate.cfg
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${DOMAIN_NAME-mydomain.com}
DNS.2 = *.${DOMAIN_NAME-mydomain.com}
IP.1 = ${IP1}
IP.2 = ${IP2}
IP.3 = ${IP3}
EOF

cat <<EOF > ${HOME}/.vnc/server.cnf
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
IP.3 = ${IP3}        
EOF

test -f ${HOME}/.vnc/self.pem  || (openssl genrsa -out ${HOME}/.vnc/self.key 2048;openssl req -new -sha256 -key ${HOME}/.vnc/self.key -config ${HOME}/.vnc/server.cnf -out server.csr ;openssl x509 -req -in server.csr -CA /usr/share/cert/ca.crt -CAkey /usr/share/cert/ca.key -CAcreateserial -out ${HOME}/.vnc/self.crt -days 3650 -sha256 -extfile ${HOME}/.vnc/certificate.cfg ;rm server.csr;cat ${HOME}/.vnc/self.crt ${HOME}/.vnc/self.key > ${HOME}/.vnc/self.pem)



# first entry is control, second is view (if only one is valid for both)
mkdir -p "$HOME/.vnc"
PASSWD_PATH="$HOME/.kasmpasswd"
if [[ -f $PASSWD_PATH ]]; then
    echo -e "\n---------  purging existing VNC password settings  ---------"
    rm -f $PASSWD_PATH
fi
VNC_PW_HASH=$(python3 -c "import crypt; print(crypt.crypt('123456', '\$5\$kasm\$'));")
VNC_VIEW_PW_HASH=$(python3 -c "import crypt; print(crypt.crypt('123456', '\$5\$kasm\$'));")
echo "kasm-user:${VNC_PW_HASH}:ow" > $PASSWD_PATH
echo "kasm-viewer:${VNC_VIEW_PW_HASH}:" >> $PASSWD_PATH
chmod 600 $PASSWD_PATH

if [[ "$DEBUG" != true ]]; then
 echo -e "\n------------------ Start VNC  Server ------------------------"
 exec 1>/dev/null
 exec 2>/dev/null 
fi
sudo service dbus start
# sudo service  network-manager start
# start processes
start_kasmvnc
xhost +
start_window_manager
start_audio_out_websocket
start_audio_out
start_upload
start_vscode
start_nginx
STARTUP_COMPLETE=1

## log connect options
echo -e "\n\n------------------ KasmVNC environment started ------------------"

# tail vncserver logs
tail -f $HOME/.vnc/*$DISPLAY.log &

# start custom startup script
custom_startup
# start ssh server

# Monitor Kasm Services
sleep 3
set +x 
while :
do
	for process in "${!KASM_PROCS[@]}"; do
		if ! ps -p   "${KASM_PROCS[$process]}" > /dev/null ; then
			# If DLP Policy is set to fail secure, default is to be resilient
			if [[ ${DLP_PROCESS_FAIL_SECURE:-0} == 1 ]]; then
				exit 1
			fi

			case $process in
				kasmvnc)
					if [ "$KASMVNC_AUTO_RECOVER" = true ] ; then
						echo "KasmVNC crashed, restarting"
						start_kasmvnc
					else
						echo "KasmVNC crashed, exiting container"
						exit 1
					fi
					;;
				window_manager)
					echo "Window manager crashed, restarting"
					start_window_manager
					;;
				kasm_audio_out_websocket)
					echo "Restarting Audio Out Websocket Service"
					start_audio_out_websocket
					;;
				kasm_audio_out)
					echo "Restarting Audio Out Service"
					start_audio_out
					;;
        nginx)
          echo "Restarting nginx Service"
          start_nginx
          ;;
        vscode)
          echo "Restarting nginx Service"
          start_vscode
          ;;
        custom)
          echo "Restarting custom Service"
          custom_startup
          ;;
				upload_server)
					echo "Restarting Upload Service"
					# TODO: This will only work if both processes are killed, requires more work
					start_upload
					;;
				*)
					echo "Unknown Service: $process"
					;;
			esac
		fi
	done
	sleep 5
done


echo "Exiting Kasm container"
