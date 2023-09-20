#!/bin/bash
MYIP=$(wget -qO- ipv4.icanhazip.com);
echo "Checking VPS"
clear
source /var/lib/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
tls="$(cat ~/log-install.txt | grep -w "Trojan WS TLS" | cut -d: -f2|sed 's/ //g')"
ntls="$(cat ~/log-install.txt | grep -w "Trojan WS none TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[40;1;37m            TROJAN ACCOUNT            \E[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

		read -rp "User: " -e user
		user_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
clear
		echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
                echo -e "\E[40;1;37m            TROJAN ACCOUNT            \E[0m"
                echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			read -n 1 -s -r -p "Press any key to back on menu"
			m-trojan
		fi
	done

uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#trojanws$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#trojangrpc$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json

trojanlink1="trojan://${uuid}@${domain}:${tls}?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=${domain}#${user}"
trojanlink="trojan://${uuid}@${domain}:${tls}?path=%2Ftrojan-ws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"
trojanlink2="trojan://${uuid}@${domain}:${ntls}?path=%2Ftrojan-ws&security=none&host=${domain}&type=ws#${user}"
systemctl restart xray
clear
echo -e "◇━━━━━━━━━━━━━◇" | tee -a /etc/log-create-trojan.log
echo -e "⟨ Xray/Trojan Account ⟩" | tee -a /etc/log-create-trojan.log
echo -e "◇━━━━━━━━━━━━━◇" | tee -a /etc/log-create-trojan.log
echo -e "Remarks        : ${user}" | tee -a /etc/log-create-trojan.log
echo -e "Host/IP        : ${domain}" | tee -a /etc/log-create-trojan.log
echo -e "Wildcard       : ${domain}" | tee -a /etc/log-create-trojan.log
echo -e "Port TLS       : ${tls}" | tee -a /etc/log-create-trojan.log
echo -e "Port none TLS  : ${ntls}" | tee -a /etc/log-create-trojan.log
echo -e "Port gRPC      : ${tls}" | tee -a /etc/log-create-trojan.log
echo -e "Key            : ${uuid}" | tee -a /etc/log-create-trojan.log
echo -e "Path           : /trojan-ws" | tee -a /etc/log-create-trojan.log
echo -e "ServiceName    : trojan-grpc" | tee -a /etc/log-create-trojan.log
echo -e "◇━━━━━━━━━━━━━◇" | tee -a /etc/log-create-trojan.log
echo -e "Link TLS       : ${trojanlink}" | tee -a /etc/log-create-trojan.log
echo -e "◇━━━━━━━━━━━━━◇" | tee -a /etc/log-create-trojan.log
echo -e "Link none TLS  : ${trojanlink2}" | tee -a /etc/log-create-trojan.log
echo -e "◇━━━━━━━━━━━━━◇" | tee -a /etc/log-create-trojan.log
echo -e "Link gRPC      : ${trojanlink1}" | tee -a /etc/log-create-trojan.log
echo -e "◇━━━━━━━━━━━━━◇" | tee -a /etc/log-create-trojan.log
echo -e "Expired On     : $exp" | tee -a /etc/log-create-trojan.log
echo -e "◇━━━━━━━━━━━━━◇" | tee -a /etc/log-create-trojan.log
echo "" | tee -a /etc/log-create-trojan.log
read -n 1 -s -r -p "Press any key to back on menu"
m-trojan
