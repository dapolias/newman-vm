#!/usr/bin/env bash

printf "Installing \e[0;36mElastic Search\e[0m \n"

if [[ -a ../artifacts/elasticsearch-2.0.0.deb ]]; then
    cp ../artifacts/elasticsearch-2.0.0.deb /tmp/
else
    pushd /tmp/
    sudo wget https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.0.0/elasticsearch-2.0.0.deb
    popd
fi

sudo cp ../artifacts/elasticsearch.yml /etc/elasticsearch/

pushd /tmp/

sudo dpkg -i elasticsearch-2.0.0.deb

sudo mkdir -p /var/backups/elasticsearch
sudo mkdir /etc/elasticsearch/scripts
sudo echo "doc['sent_count'].value + doc['received_count'].value" >  /etc/elasticsearch/scripts/email_addr-sent-rcvd-sum.groovy

sudo update-rc.d elasticsearch defaults 95 10
sudo /etc/init.d/elasticsearch start

printf "Installing Python \e[0;36mElastic Search Package\e[0m \n"
sudo pip install elasticsearch

printf "Installing carrot2 \e[0;36mElastic Search Plugin\e[0m \n"
sudo /usr/share/elasticsearch/bin/plugin install org.carrot2/elasticsearch-carrot2/2.0.0

printf "Installing Head  \e[0;36mElastic Search Plugin\e[0m \n"
sudo /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head

sudo /etc/init.d/elasticsearch restart

popd
