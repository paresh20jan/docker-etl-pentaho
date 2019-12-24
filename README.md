# Reference 	: http://blog.know.bi/scalable-pdi-architecture-using-docker
# GIT link 	: https://github.com/knowbi/scalable-pdi-docker


#Copy data-integration folder post downloading code from GitHub
sudo cp -rf  /home/pareshra/data-integration/* /home/pareshra/docker-etl-pentaho/base/data-integration/

# docker-etl-pentaho : Dockerize Pentaho Development from /docker-etl-pentaho/base$ 

sudo docker build -t pdi .

# from /docker-etl-pentaho/provision$ 
sudo docker build -t provisioned-pdi .
sudo docker run -it provisioned-pdi

# Stop existing container

sudo docker stop myPerconaContainer
sudo docker rm myPerconaContainer


sudo docker stop myMongoContainer
sudo docker rm myMongoContainer


sudo docker stop pd-docker
sudo docker rm pd-docker

# start mysql container
sudo docker pull percona:5.7
sudo docker run \
--name myPerconaContainer \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=test \
-e MYSQL_DATABASE=test \
-e MYSQL_USER=test \sudogocc
-e MYSQL_PASSWORD=test \
-d percona:5.7

# start mongo db container
docker pull mongo:3.3
sudo docker run \
--name myMongoContainer \
-p 27017:27017 \
-d mongo:3.3

# start postgress db container

sudo docker pull postgres: latest
mkdir -p $HOME/docker/volumes/postgres
sudo docker run --rm   --name pg-docker -e POSTGRES_PASSWORD=docker -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data  postgres



# test if pdi is working on container

sudo docker run -p 9145:9145 -it  provisioned-pdi


nohup ./pan.sh -norep -file=/opt/data-integration/samples/transformations/ProcessID.ktr -logfile=/opt/data-integration/logs/etl.log

nohup ./kitchen.sh -norep -file=/opt/data-integration/samples/jobs/job_load_data_for_virt_demo.kjb -logfile=/opt/data-integration/logs/etl.log

nohup ./pan.sh -norep -file=/opt/data-integration/samples/transformations/stg_load_airline_data.ktr -logfile=/opt/data-integration/logs/etl.log
nohup ./kitchen.sh -norep -file=/opt/data-integration/samples/jobs/job_load_data_for_stg_ontime.kjb -logfile=/opt/data-integration/logs/etl.log

# on local pentaho server
nohup ./pan.sh -norep -file=samples/transformations/stg_load_airline_data.ktr "-param:file_name=1996.csv" -logfile=logs/etl.log
nohup ./kitchen.sh -norep -file=samples/jobs/job_load_data_for_stg_ontime.kjb "-param:file_name=1997.csv" -logfile=logs/etl.log

# verify etl log
cat logs/etl.log



#Verify volume mounting

sudo docker run -it --name devtest -v "$(pwd)"/data:/opt/data-integration/data provisioned-pdi
sudo docker inspect devtest
sudo docker stop devtest
sudo docker rm devtest

#Up Prometheus and Grok Exporter

	#Download code on localdrive
		https://github.com/stefanprodan/dockprom

	#stop existing docker 
		sudo docker-compose down


	#Run following on dockprom folder 
		sudo docker-compose up -d

	#Run Grafana

		sudo docker exec -it --user root grafana bash

	# in the container you just started:
		chown -R root:root /etc/grafana && \
		chmod -R a+r /etc/grafana && \
		chown -R grafana:grafana /var/lib/grafana && \
		chown -R grafana:grafana /usr/share/grafana


	Prometheus URL
		http://localhost:9090

	Grafana URL
		http://localhost:3000

	#Run from Grok directory https://github.com/fstab/grok_exporter
		
		 pareshra@pareshra-ubt18:~/grok$ ./grok_exporter -config ./example/configPentahoLog.yml




#run kettle job from docker run

sudo docker run --privileged -v "$(pwd)"/data:/opt/data-integration/data provisioned-pdi  script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/trans/stg_load_airline_data.ktr "-param:file_name=1996.csv"

sudo docker run --privileged -v "$(pwd)"/data:/opt/data-integration/data provisioned-pdi  script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/trans/stg_load_airline_data.ktr "-param:file_name=1997.csv"

sudo docker run --privileged -v "$(pwd)"/data:/opt/data-integration/data provisioned-pdi  script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/jobs/job_load_data_for_stg_ontime.kjb "-param:file_name=1997.csv"

sudo docker run --stop-timeout=60 --privileged -v "$(pwd)"/data:/opt/data-integration/data provisioned-pdi  script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/jobs/job_load_data_for_stg_ontime.kjb "-param:file_name=1996.csv"


sudo docker run -p 9145:9145 --privileged -v "$(pwd)"/data:/opt/data-integration/data provisioned-pdi  script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/jobs/job_load_data_for_stg_ontime.kjb "-param:file_name=1997.csv"

sudo docker run -p 9145:9145 --privileged -v "$(pwd)"/data:/opt/data-integration/data provisioned-pdi -v "$(pwd)"/etllog:/opt/data-integration/logs script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/jobs/job_load_data_for_stg_ontime.kjb "-param:file_name=1997.csv"

sudo docker run --privileged -v "$(pwd)"/data:/opt/data-integration/data -v "$(pwd)"/grok/example:/opt/data-integration/logs provisioned-pdi script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/jobs/job_load_data_for_stg_ontime.kjb "-param:file_name=1997.csv"


sudo docker run --privileged -v "$(pwd)"/data/Master:/opt/data-integration/data -v "$(pwd)"/grok/example:/opt/data-integration/logs provisioned-pdi script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/jobs/Loading_Staging_Airport_Job.kjb "-param:file_name=airports.csv"


sudo docker run --privileged -v "$(pwd)"/data/Master:/opt/data-integration/data -v "$(pwd)"/grok/example:/opt/data-integration/logs provisioned-pdi script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/trans/stg_load_carrier_data.ktr "-param:file_name=carriers.csv"

sudo docker run --privileged -v "$(pwd)"/data/Master:/opt/data-integration/data -v "$(pwd)"/grok/example:/opt/data-integration/logs provisioned-pdi script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/trans/stg_load_airport_data.ktr "-param:file_name=airports.csv"

sudo docker run --privileged -v "$(pwd)"/data/Master:/opt/data-integration/data -v "$(pwd)"/grok/example:/opt/data-integration/logs provisioned-pdi script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/trans/stg_load_plane_date.ktr "-param:file_name=plane-data.csv"

sudo docker run --privileged -v "$(pwd)"/data/Master:/opt/data-integration/data -v "$(pwd)"/grok/example:/opt/data-integration/logs provisioned-pdi script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/trans/stg_load_state_data.ktr "-param:file_name=initial_state_code.csv"

sudo docker run --privileged -v "$(pwd)"/data/Transactional:/opt/data-integration/data -v "$(pwd)"/grok/example:/opt/data-integration/logs provisioned-pdi script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/trans/stg_load_ontime_data.ktr "-param:file_name=1996.csv"


sudo docker run --privileged -v "$(pwd)"/data/Master:/opt/data-integration/data -v "$(pwd)"/grok/example:/opt/data-integration/logs provisioned-pdi script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/trans/stg_load_all_files.ktr

sudo docker run --privileged -v "$(pwd)"/data/Master:/opt/data-integration/data -v "$(pwd)"/grok/example:/opt/data-integration/logs provisioned-pdi script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/trans/dim_load_carrier_data.ktr

sudo docker run --privileged -v "$(pwd)"/data/Master:/opt/data-integration/data -v "$(pwd)"/grok/example:/opt/data-integration/logs provisioned-pdi script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/trans/dim_load_destairport_data.ktr

sudo docker run --privileged -v "$(pwd)"/data/Master:/opt/data-integration/data -v "$(pwd)"/grok/example:/opt/data-integration/logs provisioned-pdi script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/trans/dim_load_orgairport_data.ktr

sudo docker run --privileged -v "$(pwd)"/data/Master:/opt/data-integration/data -v "$(pwd)"/grok/example:/opt/data-integration/logs provisioned-pdi script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/trans/dim_load_plane_data.ktr

sudo docker run --privileged -v "$(pwd)"/data/Transactional:/opt/data-integration/data -v "$(pwd)"/grok/example:/opt/data-integration/logs provisioned-pdi script.sh https://github.com/pareshrane/docker-etl-pentaho provision/build/etl/trans/fact_load_ontime_data.ktr "-param:p_year=1998"





# Empty data-integration folder before uploading code to GitHub
sudo rm -r  /home/pareshra/docker-etl-pentaho/base/data-integration/*

sudo git add .
sudo git commit -m "First commit"
sudo git remote add origin https://github.com/pareshrane/docker-etl-pentaho.git
git remote -v
git push origin master



# kill all provisional container at regular hours
sudo docker rm $(sudo docker stop $(sudo docker ps -a -q --filter ancestor=provisioned-pdi --format="{{.ID}}"))

# Kill All Docker container
docker kill $(sudo docker ps -q)



