#!/usr/bin/env bash
set -ex
DEFAULT_PROFILE_HOME=/home/kasm-default-profile
PROFILE_SYNC_DIR=/kasm_profile_sync

function set_user_permission {
   for var in "$@"
   do
    echo "fix permissions for: $var"
    find "$var"/ -name '*.sh' -exec chmod $verbose a+x {} +
    find "$var"/ -name '*.desktop' -exec chmod $verbose a+x {} +
    #chgrp -R 0 "$var" && chmod -R $verbose a+rw "$var" && find "$var" -type d -exec chmod $verbose a+x {} +
   done    
}

function copy_default_profile_to_home {
    echo "Copying default profile to home directory"
    # sudo chown -R 1000:0  $DEFAULT_PROFILE_HOME/ 
    if [  -d "$HOME/.vnc" ]; then
        sudo chown -R 1000:0  $HOME/.vnc
    fi

    # sudo  cp -rp $DEFAULT_PROFILE_HOME/.  $HOME/
}



function verify_profile_config {
    echo "Verifying Uploads/Downloads Configurations"

    mkdir -p $HOME/Uploads

    if [ -d "$HOME/Desktop/Uploads" ]; then
        echo "Uploads Desktop Symlink Exists"
    else
        echo "Creating Uploads Desktop Symlink"
        ln -sf $HOME/Uploads $HOME/Desktop/Uploads
    fi


    mkdir -p $HOME/Downloads

    if [ -d "$HOME/Desktop/Downloads" ]; then
        echo "Downloads Desktop Symlink Exists"
    else
        echo "Creating Download Desktop Symlink"
        ln -sf $HOME/Downloads $HOME/Desktop/Downloads
    fi


    if [ -d "$KASM_VNC_PATH/Downloads/Downloads" ]; then
        echo "Downloads RX Symlink Exists"
    else
        echo "Creating Downloads RX Symlink"
        ln -sf $HOME/Downloads $KASM_VNC_PATH/www/Downloads/Downloads
    fi

    ls -la $HOME/Desktop

}



if  [ -f "$HOME/.bashrc" ]; then
    echo "Profile already exists. Will not copy default contents"
else
    echo "Profile Sync Directory Does Not Exist. No Sync will occur"
    copy_default_profile_to_home
    set_user_permission $HOME
fi
cp -pr /etc/skel/.bash* $HOME
echo "source $STARTUPDIR/generate_container_user" >> $HOME/.bashrc
verify_profile_config
sudo rm -rf $HOME/.config/pulse
mkdir -p $HOME/.vnc
echo "${USER_NAME-kasm-user}:$(openssl passwd $VNC_PW)" > $HOME/.vnc/.htpasswd
sudo sed -i 's/@basicauth@/proxy_set_header Authorization "Basic a2FzbS11c2VyOjEyMzQ1Ng==";/g'  /etc/nginx/conf.d/websocket.conf
echo "Removing Default Profile Directory"
rm -rf $DEFAULT_PROFILE_HOME/*
sudo usermod ${USER_NAME-kasm-user} -s /bin/bash
# unknown option ==> call command
echo -e "\n\n------------------ EXECUTE COMMAND ------------------"
echo "Executing command: '$@'"
exec "$@"
