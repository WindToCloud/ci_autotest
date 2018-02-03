#!/bin/bash

# Disk negotiated link rate query
# IN : N/A
# OUT: N/A
function disk_negotiated_link_rate_query()
{
    Test_Case_Title="disk_negotiated_link_rate_query"

    for dir in `ls ${PHY_FILE_PATH}`
    do
        type=`cat ${PHY_FILE_PATH}/${dir}/target_port_protocols`
        [ x"${type}" = x"none" ] && continue

        rate_value=`cat ${PHY_FILE_PATH}/${dir}/negotiated_linkrate | awk -F '.' '{print $1}'`
        BRate=1
        for rate in `echo $DISK_NEGOTIATED_LINKRATE_VALUE | sed 's/|/ /g'`
        do
            if [ $(echo "${rate_value} ${rate}"|awk '{if($1=$2){print 0}else{print 1}}') -eq 0 ]
            then
                BRate=0
                break
            fi
        done

        if [ $BRate -eq 1 ]
        then
            MESSAGE="FAIL\t\"${dir}\" negotiated link rate query ERROR."
            return 1
        fi
    done
    MESSAGE="PASS"
}

function main()
{
    # call the implementation of the automation use cases
    test_case_function_run
}

main
