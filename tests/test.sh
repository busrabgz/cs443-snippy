#!/bin/bash

for x in {1..100}
do
  echo "Hey"
  curl -X GET http://localhost:8089/u/b3c70e29
done
