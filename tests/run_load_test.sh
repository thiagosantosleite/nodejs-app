if [[ -z $SITE_IP ]]; then SITE_IP=18.207.186.2; echo "SITE_IP is not configured, so using 18.207.186.2"; fi;
yum install httpd-tools -y
ab -n 10000000 -c 1000 http://$SITE_IP/
