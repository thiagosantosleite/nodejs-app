# nodejs-app



# Requirements:
- define a public ip or dns and define in the enviroment variable SITE_IP

# Setup environment:
```
yum install git
git clone https://github.com/thiagosantosleite/nodejs-app
cd nodejs-app/
## export the public ip 
export SITE_IP=34.201.38.56
./setup.sh
```

# Run the load tests
````
yum install git -y 
git clone https://github.com/thiagosantosleite/nodejs-app
cd nodejs-app/tests
## export the public ip 
export SITE_IP=34.201.38.56
./run_load_test.sh
````

# Load test results
## Enviroment
- App = t2.large -> 2cpu / 8GB 
- Load = t2.large -> 2cpu / 8GB 

## results
- From home throught internet 356/req sec
- From load test machine in the same vpc 3998/ req sec

## logs from home
````
[root@localhost ~]# ab -n 1000 -c 1000 http://18.207.186.2:3000/                                                                                                                   [101/1719]
This is ApacheBench, Version 2.3 <$Revision: 655654 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking 18.207.186.2 (be patient)
Completed 100 requests
Completed 200 requests
Completed 300 requests
Completed 400 requests
Completed 500 requests
Completed 600 requests
Completed 700 requests
Completed 800 requests
Completed 900 requests
Completed 1000 requests
Finished 1000 requests

Document Path:          /                                                                                                                                                           [78/1719]
Document Length:        12 bytes

Concurrency Level:      1000
Time taken for tests:   2.802 seconds
Complete requests:      1000
Failed requests:        0
Write errors:           0
Total transferred:      220284 bytes
HTML transferred:       12528 bytes
Requests per second:    356.94 [#/sec] (mean)
Time per request:       2801.603 [ms] (mean)
Time per request:       2.802 [ms] (mean, across all concurrent requests)
Transfer rate:          76.79 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:      264  418 218.8    373    1646
Processing:   256  735 483.1    401    1840
Waiting:      254  614 412.5    359    1753
Total:        584 1153 517.9    878    2215

Percentage of the requests served within a certain time (ms)
  50%    878
  66%   1435
  75%   1620
  80%   1720
  90%   1970
  95%   1993
  98%   2080
  99%   2097
 100%   2215 (longest request)
````

## Logs from load test machine
````
ab -n 10000000 -c 1000 http://18.207.186.2/
This is ApacheBench, Version 2.3 <$Revision: 1843412 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking 18.207.186.2 (be patient)
Completed 10000 requests
Completed 20000 requests
Completed 30000 requests
Completed 40000 requests
Completed 50000 requests
Completed 60000 requests
Completed 70000 requests
Completed 80000 requests
Completed 90000 requests
Completed 100000 requests
Finished 100000 requests


Server Software:
Server Hostname:        18.207.186.2
Server Port:            3000

Document Path:          /
Document Length:        12 bytes

Concurrency Level:      100
Time taken for tests:   25.009 seconds
Complete requests:      100000
Failed requests:        0
Total transferred:      21100000 bytes
HTML transferred:       1200000 bytes
Requests per second:    3998.53 [#/sec] (mean)
Time per request:       25.009 [ms] (mean)
Time per request:       0.250 [ms] (mean, across all concurrent requests)
Transfer rate:          823.92 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        1    1   3.2      1    1013
Processing:     1   24   2.3     24      41
Waiting:        1   24   2.3     24      41
Total:          4   25   3.9     25    1034

Percentage of the requests served within a certain time (ms)
  50%     25
  66%     25
  75%     26
  80%     27
  90%     28
  95%     29
  98%     31
  99%     32
 100%   1034 (longest request)
````


