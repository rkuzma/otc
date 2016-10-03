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


IMAGE_NAME=$(cat /dev/urandom | tr -dc 'A-Za-z' | fold -w 10 | head -n 1)_IMAGE

#curl -O http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img

apitest glance --insecure image-create --name ${IMAGE_NAME} --disk-format qcow2 --container-format ovf --file cirros-0.3.4-x86_64-disk.img 2>/dev/null

IMAGE_ID=`glance --insecure image-list 2>/dev/null|grep ${IMAGE_NAME}|awk '{print $2}'`


apitest glance --insecure image-delete ${IMAGE_ID} 2>/dev/null
