#Require Root Permission
[ $(id -u) != "0" ] && { echo "Error: You must be root to run this script"; exit 1; }

install_ssr(){
	cd /root/
	echo '下载ssr'
	git clone https://github.com/maxzh0916/1ClickDeploy.git && cd 1ClickDeploy && ./setup_cymysql.sh && ./initcfg.sh
	echo 'ssr安装完成'
	stty erase '^H' && read -p " mysql服务器地址:" ssserver
	stty erase '^H' && read -p " mysql服务器端口:" ssport
	stty erase '^H' && read -p " mysql服务器用户名:" ssuser
	stty erase '^H' && read -p " mysql服务器密码:" sspass
	stty erase '^H' && read -p " mysql服务器数据库名:" ssdb
	stty erase '^H' && read -p " SSR节点ID（nodeid）:" ssnode
	stty erase '^H' && read -p " 加密:" ssmethod
	stty erase '^H' && read -p " 协议:" ssprotocol
	stty erase '^H' && read -p " 混淆:" ssobfs
	sed -i -e "s/ssserver/$ssserver/g" usermysql.json
	sed -i -e "s/ssport/$ssport/g" usermysql.json
	sed -i -e "s/ssuser/$ssuser/g" usermysql.json
	sed -i -e "s/sspass/$sspass/g" usermysql.json
	sed -i -e "s/ssdb/$ssdb/g" usermysql.json
	sed -i -e "s/ssnode/$ssnode/g" usermysql.json
	sed -i -e "s/ssmethod/$ssmethod/g" user-config.json
	sed -i -e "s/ssprotocol/$ssprotocol/g" user-config.json
	sed -i -e "s/ssobfs/$ssobfs/g" user-config.json
	echo 'ssr配置完成'
	./run.sh
	cd
}
open_bbr(){
	cd
	wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh
	chmod +x bbr.sh
	./bbr.sh

}

yum -y install git
yum -y install wget
echo ' 1. 安装SSR 2. 安装BBR'
stty erase '^H' && read -p " 请输入数字 [1-2]:" num
case "$num" in
	1)
	install_ssr
	;;
	2)
	open_bbr
	;;
	*)
	echo "请输入正确数字 [1-2]"
	;;
esac