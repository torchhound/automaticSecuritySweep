#! /bin/sh
yum -y install python-pip
yum -y install libxml2-devel libxslt-devel openssl-devel python-devel
git clone https://github.com/andresriancho/w3af.git
cd w3af
./w3af_console
/tmp/w3af_dependency_install.sh