#!/usr/bin/env bash

if [ $# -eq 0 ]
then
    echo "No domain-name argument supplied."
    exit 1
else
    domain_name=$1

    host_ip=$(curl ifconfig.me)
    dns_ip=$(dig +short $domain_name)

    echo "host ip: $host_ip"
    echo "ip for $domain_name: $dns_ip"

    if [[ "$dns_ip" == "$host_ip" ]]
    then
        echo "Host IP same as IP set for $domain_name"
        echo "No change required"
    else
        echo "Host IP differs from IP set for $domain_name"
        echo "Trying to update TransIP DNS settings..."

        if tipctl.phar apiutil:test ; then
            echo "TransIP API test succeeded."
            echo "Updating DNS entry"
            tipctl.phar domain:dns:updatednsentry $domain_name @ 300 A $host_ip
        else
            echo "TransIP API test failed."
            echo "Please open this container's CMD line, and set-up the TransIP API by running ~tipctl.phar setup~"
        fi

    fi
fi

