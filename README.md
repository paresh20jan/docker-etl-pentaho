<<<<<<< HEAD
# Reference 	: http://blog.know.bi/scalable-pdi-architecture-using-docker
# GIT link 	: https://github.com/knowbi/scalable-pdi-docker

# from /scalable-pdi-docker/base$ 
sudo docker build -t pdi .


=======
# docker-etl-pentaho
Dockerize Pentaho Development

# Reference 	: http://blog.know.bi/scalable-pdi-architecture-using-docker
# GIT link 	: https://github.com/knowbi/scalable-pdi-docker

sudo docker build -t pdi .

>>>>>>> ea57fecc16947be60a39c05dc11a6f4b42a658a0
sudo docker build -t provisioned-pdi .

sudo docker run -it provisioned-pdi

# test if pdi is working on container
<<<<<<< HEAD
sudo docker exec -it provisioned-pdi bash
=======
>>>>>>> ea57fecc16947be60a39c05dc11a6f4b42a658a0
nohup ./pan.sh -norep -file=/opt/data-integration/samples/transformations/ProcessID.ktr -logfile=/opt/data-integration/logs/etl.log

# Stop existing container

sudo docker stop myPerconaContainer
sudo docker rm myPerconaContainer

sudo docker stop myMongoContainer
sudo docker rm myMongoContainer

# start mysql container
<<<<<<< HEAD
--sudo docker pull percona:5.7
=======
sudo docker pull percona:5.7
>>>>>>> ea57fecc16947be60a39c05dc11a6f4b42a658a0

sudo docker run \
--name myPerconaContainer \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=test \
-e MYSQL_DATABASE=test \
-e MYSQL_USER=test \
-e MYSQL_PASSWORD=test \
-d percona:5.7

# start mongo db container
<<<<<<< HEAD
--docker pull mongo:3.3
=======
docker pull mongo:3.3
>>>>>>> ea57fecc16947be60a39c05dc11a6f4b42a658a0

sudo docker run \
--name myMongoContainer \
-p 27017:27017 \
-d mongo:3.3

# run kettle job from docker run
sudo docker run --privileged -v /data:/pentahodata provisioned-pdi script.sh https://github.com/diethardsteiner/diethardsteiner.github.io sample-files/pdi/pdi-and-teiid-data-virtualization/my-version/di/job_load_data_for_virt_demo.kjb
