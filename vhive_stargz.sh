#!/bin/bash
git clone https://github.com/vhive-serverless/vhive.git

cd vhive

git checkout stock-only-stargz-support

mkdir -p /tmp/vhive-logs

sudo ./scripts/cloudlab/setup_node.sh stock-only use-stargz > >(tee -a /tmp/vhive-logs/setup_node.stdout) 2> >(tee -a /tmp/vhive-logs/setup_node.stderr >&2)

sudo screen -dmS containerd containerd; sleep 5;

sudo ./scripts/cluster/create_one_node_cluster.sh stock-only

wget https://go.dev/dl/go1.19.5.linux-amd64.tar.gz

sudo rm -rf /usr/local/go

sudo tar -C /usr/local -xzf go1.19.5.linux-amd64.tar.gz

export PATH=$PATH:/usr/local/go/bin

sleep 30

git clone https://github.com/DavidBuzatu-Marian/vHive-stargz-experiments

cd vHive-stargz-experiments/experiments/script

sudo /usr/local/go/bin/go mod init main

sudo /usr/local/go/bin/go build main.go

sudo apt-get install wondershaper
	
sudo apt install vnstat

./main base-objectrec-test estargz-objectrec-test