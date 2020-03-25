#!/bin/bash
source /opt/env-repositories.sh

for i in "${PLUGINS_LIST_NEO_PACKAGE[@]}"
do 
	echo "GOING TO BUILD PLUGIN ${i}\n"
	/opt/build_plugin_3x.sh --plugin-name ${i}
	res=$?
	if [ $res = 1 ]; then
	    echo "GOING TO EXIT BECAUSE LAST VERIFICATION RETURNED $res\n"
	    exit 1
	fi
done

for i in "${PLUGINS_LIST_NO_NEO_PACKAGE[@]}"
do 
	echo "GOING TO BUILD PLUGIN ${i} THAT WE DO NOT NEED TO REMOVE NEO. NO REFERENCE TO BASE CORE LIBRARY.\n"
	/opt/build_plugin_3x.sh --plugin-name ${i}
	res=$?
	if [ $res = 1 ]; then
	    echo "GOING TO EXIT BECAUSE LAST VERIFICATION RETURNED $res\n"
	    exit 1
	fi
done

for i in "${PLUGINS_UT_LIST[@]}"
do 
	echo "GOING TO CALL TEST ${i} FOR PLUGINS\n"
	/opt/test_plugin_3x.sh --module-test-name ${i}
	res=$?
	if [ $res = 1 ]; then
	    echo "GOING TO EXIT BECAUSE LAST VERIFICATION RETURNED $res\n"
	    exit 1
	fi
done

