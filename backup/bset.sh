#!/bin/bash

mkdir -p /etc/rapzvpn

bckup() {
clear
echo "================================================"
echo "                 BACKUP SETTING                 "
echo "================================================"
echo -ne "Input your Bot Token: "; read bot_token
echo -ne "Input your Chat ID: "; read chat_id
echo "================================================"

echo -n "$bot_token" > /etc/rapzvpn/bot_token 
echo -n "$chat_id" > /etc/rapzvpn/chat_id
echo "Done!"
read -p "Press enter to go back" -n 1; m-dns
}

clear
echo "================================================"
echo "                 BACKUP SETTING                 "
echo "================================================"
path="/etc/rapzvpn/bot_token"
if [ -e "$path" ]; then
   echo "You already set the backup setting up!"
   echo -ne "Want to change the information instead? [Y/n]: "; read confirm
   if [[ "$confirm" = [Yy] ]]; then
      bckup
   else
      m-dns
   fi
else
   bckup
fi
