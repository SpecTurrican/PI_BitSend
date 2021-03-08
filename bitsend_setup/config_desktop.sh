#!/bin/bash

# BASICS
SCRIPT_VERSION="08032021"
COIN_NAME="BitSend"
COIN=$(echo ${COIN_NAME} | tr '[:upper:]' '[:lower:]')

# DIRS
HOME="/home/${COIN}/"
COIN_HOME="${HOME}.${COIN}/"
INSTALL_DIR="/root/PI_${COIN_NAME}/"
COIN_MEDIA="${HOME}MEDIA/"
GRAPHIX_FORMAT="png"
COIN_WALLPAPER="${COIN}_wallpaper.${GRAPHIX_FORMAT}"
COIN_ICON="${COIN}_icon.${GRAPHIX_FORMAT}"

# Install Script
SCRIPT_DIR="${INSTALL_DIR}${COIN}_setup/"
SCRIPT_NAME="config_desktop.sh"

# Logfile
LOG_DIR="${INSTALL_DIR}logfiles/"
LOG_FILE="config_desktop.log"

# Commands
HOME_USER_COMMAND="sudo -u ${COIN}"

# Application
APPS="gedit ristretto"

# Desktopcolor
DESKTOP_BG="#c238c238c238"
DESKTOP_SHADOW="#c238c238c238"
DESKTOP_FG="#0f0f7676cccc"
BG_COLOR="#5f5fb7b7ffff"
FG_COLOR="#f0f0f0f0f0f0"
BAR_BG_COLOR="#5f5fb7b7ffff"
BAR_FG_COLOR="#000000000000"

app_install () {

	sleep 5
	apt-get -y update && apt-get -y upgrade
	sleep 2
	apt-get install -y $APPS


}

config_desktop () {

	#
	# Copy Wallpaper and Icons for Desktop
	[ ! -d "$COIN_MEDIA" ] && $HOME_USER_COMMAND /bin/mkdir -p $COIN_MEDIA
	cp ${SCRIPT_DIR}${COIN_WALLPAPER} ${COIN_MEDIA}
	cp ${SCRIPT_DIR}${COIN_ICON} ${COIN_MEDIA}
	/bin/chown -R -f ${COIN} ${COIN_MEDIA}

	#
	# Set Desktop Application
	[ ! -d "${HOME}.local/share/applications" ] && $HOME_USER_COMMAND /bin/mkdir -p ${HOME}.local/share/applications
	[ ! -d "${HOME}Desktop" ] && $HOME_USER_COMMAND /bin/mkdir -p ${HOME}Desktop

	#
	# Set Menu Application
	$HOME_USER_COMMAND echo "
		[Desktop Entry]
		Name=${COIN_NAME} QT
		Comment=Blockchain Wallet from ${COIN_NAME}
		Exec=${COIN}-qt
		Icon=${COIN_MEDIA}${COIN_ICON}
		Terminal=false
		Type=Application
		Categories=Blockchain;
		Keywords=blockchain;wallet;${COIN};
	" > ${HOME}.local/share/applications/${COIN}-qt.desktop

	#
	# Set Desktop link
	$HOME_USER_COMMAND echo "
		[Desktop Entry]
		Type=Link
		Name=${COIN_NAME} QT
		Icon=${HOME}MEDIA/${COIN}_icon.png
		URL=${HOME}.local/share/applications/${COIN}-qt.desktop" > ${HOME}Desktop/${COIN}-qt.desktop

	#
	# Set Desktop Wallpaper
	[ ! -d "${HOME}.config/pcmanfm/LXDE-pi" ] && $HOME_USER_COMMAND /bin/mkdir -p ${HOME}.config/pcmanfm/LXDE-pi
	$HOME_USER_COMMAND echo "
		[*]
		desktop_bg=${DESKTOP_BG}
		desktop_shadow=${DESKTOP_SHADOW}
		desktop_fg=${DESKTOP_FG}
		desktop_font=Monospace 12
		wallpaper=${COIN_MEDIA}${COIN_WALLPAPER}
		wallpaper_mode=fit
		show_documents=0
		show_trash=1
		show_mounts=1
	" > ${HOME}.config/pcmanfm/LXDE-pi/desktop-items-0.conf

	#
	# Set Desktop
	[ ! -d "${HOME}.config/lxsession/LXDE-pi" ] && $HOME_USER_COMMAND /bin/mkdir -p ${HOME}.config/lxsession/LXDE-pi
	$HOME_USER_COMMAND echo "
		[GTK]
		sGtk/ColorScheme=selected_bg_color:${BG_COLOR}\nselected_fg_color:${FG_COLOR}\nbar_bg_color:${BAR_BG_COLOR}\nbar_fg_color:${BAR_FG_COLOR}\n
		sGtk/FontName=Monospace 12
		iGtk/ToolbarIconSize=3
		sGtk/IconSizes=gtk-large-toolbar=24,24
		iGtk/CursorThemeSize=24" > ${HOME}.config/lxsession/LXDE-pi/desktop.conf

	#
	# Copy info.txt (with Masternodekey and IP) on Desktop
	$HOME_USER_COMMAND cp ${HOME}info.txt ${HOME}Desktop

}

finish () {

	/usr/bin/touch /boot/${COIN}_config_desktop
	echo $SCRIPTVERSION > /boot/${COIN}_config_desktop
	/usr/bin/crontab -u root -r
	echo "Desktop is finish ..."


}


	#
	# Is the service installed ?

	if [ -f /boot/${COIN}_config_desktop ]; then

		echo "Previous ${COIN}_config_desktop detected. Install aborted."

	else
		app_install
		config_desktop
		finish
	
	fi