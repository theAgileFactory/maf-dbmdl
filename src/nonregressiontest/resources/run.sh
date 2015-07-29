#!/bin/sh

BASEFOLDER=$1
export BASEFOLDER
PROPERTIESFILE=$2
export PROPERTIESFILE

echo "This file is used to run the automated test"
echo "Parameter are the base folder = wher to find deploy.sh, etc and the properties file to used for the required properties for this automated testing"

mkdir -p ../nonregression/

echo 'Result must be wrote into the folder ../nonregression, in junit format'

echo 'create a dummy test result, just to test the process'
echo '<testsuite failures="0" time="0.1" errors="0" skipped="0" tests="1"><testcase classname="dummy" name="NoSmokeTest"/></testsuite>' > ../nonregression/TEST-dummy.xml
