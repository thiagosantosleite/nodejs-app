#!/bin/bash
cat /var/log/nginx/access.log | awk ' { print $5 "  " $7} ' | sort | uniq -c  | sort -nr > out.out
cat out.out
