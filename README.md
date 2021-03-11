# PI_BitSend
## BitSend for Raspberry Pi 2/3/4 with Desktop RPD and remonte SSH/RDP control.

Needs:

+ ISO Raspbian Lite (https://www.raspberrypi.org/downloads/raspbian/)
+ 16GB SD-Card
+ A Raspberry Pi 2/3/4 (with minimum 1GB Ram)
+ Login as ROOT (start Raspberry Pi and login as 'pi' user... password is 'raspberry'... 'sudo su root')

You can execute the following install script. Just copy/paste and hit "Enter"-key.
```
wget -qO - https://raw.githubusercontent.com/SpecTurrican/PI_BitSend/master/setup.sh | bash
```
The installation goes into the background. You can follow the installation with :
```
sudo tail -f /root/PI_BitSend/logfiles/start.log  # 1. Phase "Prepar the system"
sudo tail -f /root/PI_BitSend/logfiles/make.log   # 2. Phase "Compiling"
sudo tail -f /root/PI_BitSend/logfiles/config_desktop.log   # 3. Phase "Configuration of the Bitcore user interface"
```
The installation takes about 3-6 hours.
The Raspberry Pi is restarted 3 times during the installation.
After the installation the following user and password is valid :
```
bitsend
```
Please change your password !!!

You can with RDP (on Windows "mstsc") or via HDMI start the BitSend QT on the Desktop.

In the File "info.txt" on your Desktop is the Masternode Key and External IP.

You need only the console ?

Start the service with:
```
sudo systemctl enable bitsend.service
```

If everything worked out, you can retrieve the status with the following command :
```
bitsend-cli -getinfo            # general information
bitsend-cli masternode debug    # is the masternode running ?
bitsend-cli masternode count    # how much mastenode ?
bitsend-cli help                # list of commands
```
## Configfile
The configfile for bitsend is stored in:
```
/home/bitsend/.bitsend/bitsend.conf
```
Settings during installation:
```
rpcuser=bitsendpixxxxxxxxx                  # x=random
rpcpassword=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  # x=random
rpcallowip=127.0.0.1
port=8886
rpcport=8885
server=1
listen=1
daemon=1
promode=1
maxconnections=64
logtimestamps=1
txindex=1
externalip="Your IPv4 adress":8886
masternodeaddr=127.0.0.1:8886
masternode=1
masternodeprivkey="Your Masternode Key"

#############
# NODE LIST #
#############
addnode=add a node from https://chainz.cryptoid.info/bsd/api.dws?q=nodes list
...
```
## Security
- You have a Firewall or Router ? Please open the Port 8886 for your raspberry pi. Thanks!
- fail2ban is configured with 24 hours banntime. (https://www.fail2ban.org/wiki/index.php/Main_Page)
- ufw service open ports is 22 (SSH), 3389 (RDP) and 8886 (BitSend). (https://help.ubuntu.com/community/UFW)

## Infos about BitSend
[Homepage](https://bitsend.cc/) | [Source GitHub](https://github.com/LIMXTEC/BitSend) | [Blockchainexplorer](https://chainz.cryptoid.info/bsd/) | [Telegram](https://t.me/bitsend_cc) | [bitcointalk.org](https://bitcointalk.org/index.php?topic=1370307.0)

## Screenshoot
![ScreenShot](https://raw.githubusercontent.com/SpecTurrican/PI_BitSend/master/bitsend_setup/Screenshoot.png?raw=true)

## Have fun and thanks for your support :-)
BSD donate to :
```
iM6CwZhduYEvuuyWgAbqtettsx1pmX9pbb
```
