#!/usr/bin/env bash


apt-get -y install cmake
#apt-get -y install libopenblas-base libopenblas-dev

printf "Creating \e[0;36mMITIE\e[0m \n"

cd /srv/software 

git clone https://github.com/mit-nlp/MITIE

cd /srv/software/MITIE

if [ -a /vagrant/artifacts/MITIE-models-v0.2.tar.bz2 ]; then
    cp /vagrant/artifacts/MITIE-models-v0.2.tar.bz2 /srv/software/MITIE/
    tar -xjf MITIE-models-v0.2.tar.bz2
else
    make MITIE-models
fi 

if [ -a /vagrant/artifacts/MITIE-models-v0.2-Spanish.zip ]; then
    cp /vagrant/artifacts/MITIE-models-v0.2-Spanish.zip /srv/software/MITIE/
    unzip MITIE-models-v0.2-Spanish.zip
else
    sudo wget https://sourceforge.net/projects/mitie/files/binaries/MITIE-models-v0.2-Spanish.zip    
    unzip MITIE-models-v0.2-Spanish.zip
fi 

cd tools/ner_stream

mkdir build

cd build

cmake ..

cmake --build . --config Release

cd /srv/software/MITIE/mitielib
make

mkdir build
cd build
cmake ..
cmake --build . --config Release --target install
