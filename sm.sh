cat /var/log/nginx/access.log | awk ' { print $5 "  " $7} ' | sort | uniq -c  | sort -nr > out.out
cat out.out
curl -s --url 'smtps://smtp.gmail.com:465' --ssl-reqd   --mail-from 'thiagogvdasa@gmail.com' --mail-rcpt 'thiagogvdasa@gmail.com'   --upload-file out.out --user 'xxxxxx:passssss'
