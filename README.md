# Reference 	: http://blog.know.bi/scalable-pdi-architecture-using-docker
# GIT link 	: https://github.com/knowbi/scalable-pdi-docker


#Copy data-integration folder post downloading code from GitHub
sudo cp -rf  /home/paresh_rane/data-integration/* /home/paresh_rane/docker-etl-pentaho/base/data-integration/

# docker-etl-pentaho : Dockerize Pentaho Development from /docker-etl-pentaho/base$ 

sudo docker build -t pdi .

# from /docker-etl-pentaho/provision$ 
sudo docker build -t provisioned-pdi .
sudo docker run -it provisioned-pdi

# test if pdi is working on container

nohup ./pan.sh -norep -file=/opt/data-integration/samples/transformations/ProcessID.ktr -logfile=/opt/data-integration/logs/etl.log

nohup ./kitchen.sh -norep -file=/opt/data-integration/samples/jobs/job_load_data_for_virt_demo.kjb -logfile=/opt/data-integration/logs/etl.log

nohup ./pan.sh -norep -file=/opt/data-integration/samples/transformations/stg_load_airline_data.ktr -logfile=/opt/data-integration/logs/etl.log
#nohup ./kitchen.sh -norep -file=/opt/data-integration/samples/jobs/job_load_data_for_stg_ontime.kjb -logfile=/opt/data-integration/logs/etl.log

# on local pentaho server
./pan.sh -norep -file=samples/transformations/stg_load_airline_data.ktr "-param:file_name=1996.csv"


# verify etl log
cat logs/etl.log

# Stop existing container

sudo docker stop myPerconaContainer
sudo docker rm myPerconaContainer

sudo docker stop myMongoContainer
sudo docker rm myMongoContainer

# start mysql container
sudo docker pull percona:5.7
sudo docker run \
--name myPerconaContainer \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=test \
-e MYSQL_DATABASE=test \
-e MYSQL_USER=test \
-e MYSQL_PASSWORD=test \
-d percona:5.7

# start mongo db container
docker pull mongo:3.3
sudo docker run \
--name myMongoContainer \
-p 27017:27017 \
-d mongo:3.3

#Verify volume mounting

sudo docker run -it --name devtest -v "$(pwd)"/data:/opt/data-integration/data provisioned-pdi
sudo docker inspect devtest
sudo docker stop devtest
sudo docker rm devtest


# run kettle job from docker run

sudo docker run --privileged -v "$(pwd)"/data:/opt/data-integration/data provisioned-pdi  script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/trans/stg_load_airline_data.ktr "-param:file_name=1996.csv"

sudo docker run --privileged -v "$(pwd)"/data:/opt/data-integration/data provisioned-pdi  script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/trans/stg_load_airline_data.ktr "-param:file_name=1997.csv"

sudo docker run --privileged -v "$(pwd)"/data:/opt/data-integration/data provisioned-pdi  script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/jobs/job_load_data_for_stg_ontime.kjb "-param:file_name=1997.csv"



#Empty data-integration folder before uploading code to GitHub
sudo rm -r  /home/paresh_rane/docker-etl-pentaho/base/data-integration/*
