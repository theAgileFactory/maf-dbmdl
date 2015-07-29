#!/bin/sh

# mvn -f migration-pom.xml -Dmigration.env=deploy migration:status 
./migrate.sh status --path=../repo --env=deploy
