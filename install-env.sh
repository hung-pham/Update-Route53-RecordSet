#!/bin/bash
main(){
    #install_util_tools111
    install_aws_cli
    install_jq_lib
    install_run_script
}

install_util_tools() {
    # Install basic tools
    echo "INFO: Installing basic tools..."
    apt-get -y install git unzip
}

install_aws_cli(){
    curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
    unzip awscli-bundle.zip
    sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

    mkdir ~/.aws
    echo "Configuring " 
    echo "[default]
aws_access_key_id = AKIAJ3TL62KOCDCT4GNQ
aws_secret_access_key = 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" | sudo tee ~/.aws/credentials

    echo "[default]
output = json
region = us-east-1" | sudo tee ~/.aws/config

    sudo mkdir /root/.aws
    echo "Configuring " 
    echo "[default]
aws_access_key_id = AKIAJ3TL62KOCDCT4GNQ
aws_secret_access_key = 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" | sudo tee /root/.aws/credentials

    echo "[default]
output = json
region = us-east-1" | sudo tee root/.aws/config

}

install_jq_lib(){
    wget http://stedolan.github.io/jq/download/linux64/jq
    sudo chmod +x ./jq
    sudo cp jq /usr/bin
}

install_run_script(){
    #Install the script runs at boot time
    if [ -f "update-route53-record.sh" ]; then
        sudo cp update-route53-record.sh /etc/init.d/
        sudo ln -s /etc/init.d/update-route53-record.sh /etc/rc6.d/K02update-route53-record.sh
    else
        echo "ERROR: update-route53-record.sh is not exist."  
    fi

    #Install the script runs at shutdown time
    if [ -f "update-route53-record.sh" ]; then
        sudo cp delete-route53-record.sh /etc/init.d/
        sudo ln -s /etc/init.d/delete-route53-record.sh /etc/rc0.d/K99delete-route53-record.sh
    else
        echo "ERROR: delete-route53-record.sh is not exist."  
    fi 
}

main
exit 0
