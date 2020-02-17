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
