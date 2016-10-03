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


VOLUME_NAME=$(cat /dev/urandom | tr -dc 'A-Za-z' | fold -w 10 | head -n 1)_VOLUME

apitest cinder --insecure create --name ${VOLUME_NAME} 5 2>/dev/null
sleep 10
apitest cinder --insecure show ${VOLUME_NAME} 2>/dev/null
sleep 10
apitest cinder --insecure delete ${VOLUME_NAME} 2>/dev/null
