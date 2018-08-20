#!/bin/sh
docker login -u ${1} -p ${2}
docker tag  littlekidogo/qb:staging littlekidogo/qb:staging
docker push littlekidogo/qb:staging
