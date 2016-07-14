#!/usr/bin/env bash

printf "Setting up build directories so user 'vagrant' can build stuff ...\n"

sudo mkdir -p /srv/software 
sudo chmod 755 /srv/software 
sudo chown vagrant.vagrant /srv/software 

printf "Let's update and install some system software!"

sudo add-apt-repository -y ppa:igraph/ppa 

sudo apt-get -y update
sudo apt-get -y upgrade

sudo apt-get -y install zip
sudo apt-get -y install p7zip-full
sudo apt-get -y install pkg-config python-pip python-dev
sudo apt-get -y install netcat git unzip
sudo apt-get -y install htop
sudo apt-get -y install iperf

printf "Now some more application specific stuff ...\n"

pushd provision

. os_config.sh

. mysql.sh

. java.sh

. scala.sh

. spark.sh

. elasticsearch.sh

. kibana.sh

. tangelo.sh

. mitie.sh

. newman.sh

. newman-research.sh

. pst-extraction.sh

. docker.sh

popd

printf "Almost finished! Now, logout and log back in as 'vagrant' then cd /home/vagrant/newman-vm && ./_run_me_third.sh\n"