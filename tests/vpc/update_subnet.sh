#!/bin/sh
VER=1.1

apitest ()
{
    "$@"
    local status=$?
    if [ $status -ne 0 ]; then
        echo "error with $1" >&2
        echo "$@ => NOT OK " >>"native_test_result_$VER.txt"
    else
        echo "$@ => OK " >>"native_test_result_$VER.txt"
    fi
    return $status

}

echo "NATIVE TEST $VER" >"native_test_result_$VER.txt"

NETWORK_NAME=$(cat /dev/urandom | tr -dc 'A-Za-z' | fold -w 10 | head -n 1)_NETWORK
SUBNET_NAME=$(cat /dev/urandom | tr -dc 'A-Za-z' | fold -w 10 | head -n 1)_PORT
SUBNET_NAME_NEW=$(cat /dev/urandom | tr -dc 'A-Za-z' | fold -w 10 | head -n 1)_PORT


apitest neutron --insecure net-create ${NETWORK_NAME} 2>/dev/null

NETWORK_ID=`neutron --insecure net-list 2>/dev/null|grep ${NETWORK_NAME}|awk '{print $2}'`

apitest neutron --insecure subnet-create ${NETWORK_NAME} 192.168.2.0/24 --name ${SUBNET_NAME}  2>/dev/null
apitest neutron --insecure subnet-update ${SUBNET_NAME} --name ${SUBNET_NAME_NEW}  2>/dev/null


apitest neutron --insecure subnet-show  ${SUBNET_NAME_NEW}  2>/dev/null



apitest neutron --insecure subnet-delete ${SUBNET_NAME_NEW} 2>/dev/null
apitest neutron --insecure net-delete ${NETWORK_NAME} 2>/dev/null
