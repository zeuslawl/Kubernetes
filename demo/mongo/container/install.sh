#! /bin/bash

#IMPORTS imdb
mongoimport --host 127.0.0.1 --port 27017 --db imdb --collection movies --type json --file /opt/docker/json/movies.json --drop --stopOnError

mongoimport --host 127.0.0.1 --port 27017 --db imdb --collection oscars --type json --file /opt/docker/json/oscars.json --drop --stopOnError 


mongoimport --host 127.0.0.1 --port 27017 --db imdb --collection people --type json --file /opt/docker/json/people.json --drop --stopOnError



#IMPORTS edx
mongoimport --host 127.0.0.1 --port 27017 --db edx --collection bios --type json --file /opt/docker/json/bios.json --drop --stopOnError

mongoimport --host 127.0.0.1 --port 27017 --db edx --collection students --type json --file /opt/docker/json/students.json --drop --stopOnError

mongoimport --host 127.0.0.1 --port 27017 --db edx --collection books --type json --file /opt/docker/json/books.json --drop --stopOnError

#IMPORTS digg

mongoimport --host 127.0.0.1 --port 27017 --db digg --collection stories --type json --file /opt/docker/json/stories.json --drop --stopOnError


