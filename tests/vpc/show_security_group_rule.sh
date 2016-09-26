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

SECURITY_GROUP_NAME=$(cat /dev/urandom | tr -dc 'A-Za-z' | fold -w 10 | head -n 1)_SECNAME


apitest neutron --insecure security-group-list 2>/dev/null

apitest neutron --insecure security-group-create ${SECURITY_GROUP_NAME} 2>/dev/null

apitest neutron --insecure security-group-rule-create ${SECURITY_GROUP_NAME} --protocol tcp --port-range-min 23 --port-range-max 23 --remote-ip-prefix 172.31.0.224/28 2>/dev/null

apitest neutron --insecure security-group-show ${SECURITY_GROUP_NAME} 2>/dev/null

apitest neutron --insecure security-group-delete ${SECURITY_GROUP_NAME} 2>/dev/null
