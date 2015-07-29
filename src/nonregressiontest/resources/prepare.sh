#!/bin/sh

BASEFOLDER=$1
export BASEFOLDER
PROPERTIESFILE=$2
export PROPERTIESFILE
VERSION=$3
export VERSION

echo "This file is used to prepare the environment to be used to do the automated test"
echo "Parameter are the base folder = wher to find deploy.sh, etc and the properties file to used for the required properties for this automated testing"


echo "First of all, deploy the database"
(cd $BASEFOLDER && ./deploy.sh $M2_HOME maf-dbmdl com.agifac.maf $VERSION $env $repo)

# echo "Then, run the smoke test"
# (cd $BASEFOLDER && ./smoke.sh $M2_HOME maf-dbmdl com.agifac.maf $VERSION $env $repo)

# echo "Finally, copy the smoke test result into the smoke test result folder"
#mkdir -p ../smoke
#cp -R $BASEFOLDER/smokescripts/target/smoketest/target/soapui-results/* ../smoke

echo "No smoke Test for the moment, launching run.sh"
