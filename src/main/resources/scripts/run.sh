#!/bin/sh

cd `dirname $0`

chmod u+x *.sh

#echo "Drop schema until it is stable"

#mysql -u root -p@com.agifac.maf.maf-dbmdl.root.password@ -e "drop database maf;"
#mysql -u root -p@com.agifac.maf.maf-dbmdl.root.password@ -e "CREATE DATABASE maf DEFAULT CHARACTER SET utf8;"
#mysql -u root -p@com.agifac.maf.maf-dbmdl.root.password@ -e "grant all privileges on maf.* to 'maf';"

echo "Execute database migration if needed"
#mvn -f migration-pom.xml migration:up -Dmigration.env=deploy
./migrate.sh up --path=../repo --env=deploy || exit -1

echo $?
echo "End of execution"
