export OVPN_DATA=$(pwd)/openvpn-data

docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u tcp://repository:1194
docker run -v $OVPN_DATA:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki

sudo chown -R $(whoami): ./openvpn-data

docker run --name openvpn -v $OVPN_DATA:/etc/openvpn -d -p 1194:1194/tcp --cap-add=NET_ADMIN --privileged kylemanna/openvpn


docker-compose up -d openvpn

export CLIENTNAME="oa"
# with a passphrase (recommended)
docker run --rm -v $OVPN_DATA:/etc/openvpn kylemanna/openvpn easyrsa build-client-full $CLIENTNAME nopass
docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME
# without a passphrase (not recommended)
docker run --rm -v $OVPN_DATA:/etc/openvpn kylemanna/openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn
docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME nopass

docker-compose run --rm openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn

