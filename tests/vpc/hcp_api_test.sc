#!/bin/sh
VER=1.1

apitest ()
{
    "$@"
    local status=$?
    if [ $status -ne 0 ]; then
        echo "error with $1" >&2
        echo "$@ => NOT OK " >>"hcp_test_result_$VER.txt"
    else
        echo "$@ => OK " >>"hcp_test_result_$VER.txt"
    fi
    return $status

}

echo "HCP TEST $VER" >"hcp_test_result_$VER.txt"

#apitest neutron --insecure net-list
#apitest neutron --insecure net-create apitestnet
#apitest neutron --insecure subnet-list
#apitest neutron failtest-example
#apitest neutron --insecure subnet-create apitestnet 192.168.2.0/24 --name apitestsubnet1
#apitest neutron --insecure subnet-show  apitestsubnet187yt6


#apitest neutron --insecure router-list
#apitest neutron --insecure router-create apitestrouter
#apitest neutron --insecure router-list
##apitest neutron --insecure router-delete apitestrouter

#apitest neutron --insecure router-list

#apitest neutron --insecure router-interface-add apitestrouter apitestsubnet1


#apitest neutron --insecure router-list
#apitest neutron --insecure router-show apitestrouter 
#apitest neutron --insecure router-update  apitestrouter --name apitestrouter2

##apitest neutron --insecure subnet-delete apitestsubnet1
##apitest neutron --insecure net-delete apitestnet

#apitest neutron --insecure floatingip-list
#apitest neutron floatingip-show --insecure `neutron floatingip-list --quiet --insecure -c id --format csv|tail -1| tr -d '"'`

apitest neutron --insecure security-group-list
apitest neutron --insecure security-group-create apitestsecgroup
apitest neutron --insecure security-group-create apitestsecgroup2
apitest neutron --insecure security-group-rule-create apitestsecgroup --protocol tcp --port-range-min 23 --port-range-max 23 --remote-ip-prefix 172.31.0.224/28
apitest neutron --insecure security-group-show apitestsecgroup
apitest neutron --insecure security-group-update apitestsecgroup2 --name apitestsecgroup3
apitest neutron --insecure security-group-list
apitest neutron --insecure security-group-delete apitestsecgroup3
apitest neutron --insecure security-group-delete apitestsecgroup
apitest neutron --insecure security-group-list
