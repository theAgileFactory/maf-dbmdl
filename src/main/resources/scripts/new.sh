#!/bin/sh

if [ $# -ne 1 ]
then
    echo "Error in $0 - Invalid Argument Count"
    echo "Syntax: $0 step_name (note: NO space allowed!)"
	echo "Example: $0 create_table_toto"
    exit
fi

export CURRENT_VERSION='1.0.0-SNAPSHOT'
export VERSION_STR=`echo $CURRENT_VERSION | sed "s/-SNAPSHOT//g" | tr '.' '-'`

# mvn -f migration-pom.xml migration:new -Dmigration.description=v${VERSION_STR}_$1 -Dmigration.env=deploy
./migrate.sh new v${VERSION_STR}_$1 --path=../repo --env=deploy
