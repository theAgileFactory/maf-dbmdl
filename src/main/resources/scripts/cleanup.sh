#!/bin/sh

# mvn -f migration-pom.xml -Dmigration.env=deploy -Dmigration.down.steps=ALL migration:down 
./migrate.sh down ALL --path=../repo --env=deploy
