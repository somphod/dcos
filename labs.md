##Labs - Marathon

**Exercise 0 - Hello world**  
Use Marathon to launch a sample app  

1. Login to cluster and enter credentials (bootstrapuser/deleteme)
```dcos cluster setup <https://master-ip>```
2.  Edit the 0-helloworld.json and modify the id to be unique (i.e. `/hello-yourname`)  
```dcos marathon app add 0-helloworld.json```
3.  Inspect the stdout log of the task to view the output
4.  Extra credit: How do you add the app through the Marathon API?
5.  When you are done, delete the app  
```dcos marathon app remove <app-name>```

**Exercise 1 - python simple HTTP server**  
Use Marathon to launch a sample app  

1.  Edit the 0-python.json and modify the id to be unique (i.e. `/python-yourname`)  
```dcos marathon app add 0-python.json```
2.  Find the port number of the application instance
3.  SSH to the master node (download SSH key, change permissions `chmod 400 <key>`)  
```ssh -i <ssh-key> core@52.x.x.x```
4.  Curl one of the app instances
```curl http://<agent IP>:<app port number>```
5.  When you are done, delete the app  
```dcos marathon app remove <app-name>```

**Exercise 2 - nginx server**  
Use Marathon to launch nginx

1. Edit the 1-nginx.json and modify the id to be unique (i.e. `/nginx-yourname`)  
```dcos marathon app add 1-nginx.json```
2. Scale down the application by doing  
```dcos marathon app update <app name> instances=1```
3. Find the port number of the application instance
4. Go to the public agent URL and use the app instance port number  
```http://<public-agent>:<app port number>```

**Exercise 3 - Health Check toggle**  
Use Marathon to launch the toggle app

1. Edit the 3-toggle-1.json and modify the id to be unique (i.e. `/toggle-yourname`)  
```dcos marathon app add 3-toggle-1.json```
2. Find the IP and marathon port number of the application instance  
3. SSH to the master node  
```ssh -i <ssh-key> core@52.x.x.x```
4. Curl the toggle IP instance and port number  
```curl http://<toggle-instance>:<toggle port number>```
5. Curl the toggle endpoint and watch instance health through Marathon  
```curl http://<toggle-instance>:<toggle port number>/toggle```
6. Toggle some of the other instances
7.  When you are done, delete the app  
```dcos marathon app remove <app-name>```

**Exercise 4 - Application Groups**  
Use Marathon to launch the app groups

1. Edit the 4-group.json and modify the id to be unique (i.e. `/group-yourname`)  
```dcos marathon group add 4-group.json```
2. Observe Marathon launching the application group  
3. Scale out the app group  
```dcos marathon group scale group-yourname 2```
4. Scale down the app group  
```dcos marathon group scale group-yourname .5```
5.  When you are done, delete the app  
```dcos marathon group remove <app-name>```

**Exercise 5 - Rolling Upgrade**  
Kick off a rolling upgrade

1. Edit the 5-python-rolling-upgrade.json and modify the id to be unique (i.e. `/upgrade-yourname`)  
```dcos marathon app add 5-python-rolling-upgrade.json```
2. Wait until all application tasks are running
3. Update the application by change the docker container (change docker image from python:3 to python:3.5
4. From the marathon UI, view the rolling upgrade of the live application

##Labs - Service Discovery

**Exercise 1 - Mesos DNS**  
Examine Mesos-DNS  

1. Edit the 6-service-discovery.json and modify the id to be unique (i.e. `/web-yourname`)  
```dcos marathon app add 6-service-discovery.json```
2. SSH into the masternode  
```ssh -i <ssh-key> core@52.x.x.x```
3. Ping the application  
```ping -c 3 <app-id>.marathon.mesos```
4. Do a DNS lookup of the application. Which DNS server does it use?  
```dig <app-id>.marathon.mesos```
5. Do an SRV lookup of the application  
```dig srv _<app-id>._tcp.marathon.mesos```
Bonus: Examine the Mesos-DNS API

**Exercise 2 - Marathon-LB**  
Use Marathon-LB to expose the web app

1. Download the mlb.sh script and run it to install Marathon-LB  
``` ./mlb.sh ```  
2. Go to the following URL once Marathon-LB is installed  
http://[public agent IP]:9090/haproxy?stats
3. Edit the previously launched web app and add a label to map it to Marathon-lb  
```"HAPROXY_GROUP": "external"```
4. After the app redeploys, refresh the haproxy page to view the new config  
http://[public agent IP]:9090/haproxy?stats  
http://[public agent IP]:9090/_haproxy_getconfig  
5. Edit the web app and add a label for a virtual host  
```"HAPROXY_0_VHOST": "<public-agent DNS>"```  
i.e. `"HAPROXY_0_VHOST": "gatturaj-a.southeastasia.cloudapp.azure.com"`
6. Go to the public-agent URL to view the web app

**Exercise 3 - Minuteman**  
Configure a VIP for the web application

1. Edit the previously launched nginx app and check the Load Balanced box   
```      "portMappings": [
        {
          "containerPort": 80,
          "protocol": "tcp",
          "name": null,
          "labels": {
            "VIP_0": "/nginx:80"
          }
        }
      ]```
2. After the app redeploys, ssh into the master node  
```ssh -i <ssh-key> core@52.x.x.x```
3. Curl the VIP  
```curl nginx.marathon.l4lb.thisdcos.directory:80```
4. View the network monitoring page on the DC/OS UI  

**Persistent Volumes**  
Validate persistent volumes  

1. Edit the 7-mysql-pv.json and modify the id to be unique (i.e. `/mysql-yourname`)  
```dcos marathon app add 7-mysql-pv.json```
2. SSH to the master node  
```ssh -i <ssh-key> core@52.x.x.x```
3. Copy the <ssh-key> file to the master node
4. Change the <ssh-key> permissions
```chmod 400 <ssh-key>```
5. SSH to the agent node  
```ssh -i <ssh-key> <mesos-agent-IP>```
6. Login to the container where mysql is running  
```sudo docker ps```  
```sudo docker exec -it <container id> bash```
7. Login to the database  
```mysql -uben -p -h 3.3.0.6 -P 3306```  
8. Create a new table in my_database  
```show databases;```  
```use my_database```  
```create table dcos (project VARCHAR(20), owner VARCHAR(20));```  
```show tables;```  
9. Insert a row into the table  
```INSERT INTO dcos VALUES ('REDBULL','soundselect');```  
10. View the data  
```select * FROM dcos;```  
11. In Marathon, kill the task and wait for Marathon to relaunch the task
12. SSH back to the same agent, login to the database, and view the data.

##Frameworks

**HDFS**  
1. SSH to the master node  
2. Run a docker container with the hdfs-client  
```docker run -it blin/hdfs-client:0.0.1 bash```  
3. List files in HDFS  
```hadoop fs -ls hdfs://hdfs/```  
4. Create a local file  
```echo hello hdfs > test.txt```  
5. Add it to HDFS  
```hadoop fs -put test.txt hdfs://hdfs/```  
6. List files in DFS  
```hadoop fs -ls hdfs://hdfs/```  
7. Cat file in HDFS  
```hadoop fs -cat hdfs://hdfs/test.txt```

**Spark**  
1. Install Spark Frameworks  
2. From dcos-cli run the following:  
```dcos spark run --submit-args='-Dspark.mesos.coarse=true --driver-cores 1 --driver-memory 1024M --class org.apache.spark.examples.SparkPi https://downloads.mesosphere.com/spark/assets/spark-examples_2.10-1.4.0-SNAPSHOT.jar 30'```  
3. Browse to the Spark services UI to view driver  
4. Browse to the Mesos task to view driver output  
5. Re-run job with more samples  
```dcos spark run --submit-args='-Dspark.mesos.coarse=true --driver-cores 1 --driver-memory 1024M --class org.apache.spark.examples.SparkPi hdfs://hdfs/spark-examples_2.10-1.4.0-SNAPSHOT.jar 300'```

##Labs - Operations

**Exercise 0 -  DC/OS Services**  
Using systemd to inspect services

1.  Open a browser and go to the DC/OS UI  
http://<master-ip address>
2.  Click on system and inspect the list of DC/OS Services
3.  Click on a service to view more details
4.  SSH to the master node  
```ssh -i <ssh-key> core@52.x.x.x```
5.  View the list of DC/OS services. Where are the systemd unit files stored?  
```systemctl list-units | grep dcos```
6.  View the status of a specific DC/OS service  
i.e. ```systemctl status dcos-marathon```
7. View the unit file of a specific DC/OS service  
```systemctl cat dcos-marathon```  
8. Follow the log of a specific DC/OS service  
```journalctl -fu dcos-marathon```

**Exercise 1 - Logging**  
Examine logs from DC/OS CLI

1.  View list of nodes from DC/OS CLI  
```dcos node```
2.  View the last 30 lines of logs from the leading master  
```dcos node log --leader --lines 30```
3.  View the last 30 lines of logs from an agent node  
```dcos node log --mesos-id <node-id> --lines 30```
4. Follow the log from the leading master  
```dcos node log --leader --follow```
4.  View list of services  
```dcos service```
5.  View logs from service  
```dcos service log kafka```
6.  View list of tasks  
```dcos task```
7. View logs from task  
```dcos task log <task-name>```  
8. View stderr file from task sandbox  
```dcos task log <task-name> stderr```

**Exercise 2 - Metrics**  
Examine metrics from DC/OS

1.  Download a browser extension to format JSON (i.e. JSONView for Chrome)
2. Explore mesos UI, view cluster resources, logs, agent resources  
http://[mesos-master]/mesos
3.  Browse the mesos help pages  
http://[mesos-master]/mesos/master/help
4.  View the state of the cluster  
http://[mesos-master]/mesos/master/state
5. View cluster metrics  
http://[mesos-master]/mesos/metrics/snapshot
6. View individual agent metrics (run command from master)  
```curl http://[agent-IP]:5051/metrics/snapshot | jq .```
7. View Marathon metrics  
http://[mesos-master]/marathon/metrics
8. View list of marathon apps (run command from master)  
```curl http://leader.mesos/marathon/v2/apps | jq .```
9. View individual task metrics (find host and task id)  
```curl http://leader.mesos/marathon/v2/apps/<app-id> | jq .```
10. Curl agent IP and search for task ID from previous step  
```curl http://[agent-ip]:5051/monitor/statistics | jq .```

**Exercise 3 - Monitoring**
Deploy monitoring systems in Marathon

Exercise are here:  
https://github.com/mesosphere/training/tree/master/velocity-training-06-2016/monitoring

##Bonus Labs

https://github.com/mesosphere/cd-demo  
https://github.com/mesosphere/tweeter  
https://github.com/mesosphere/iot-demo

Present the demo to the class and receive mad props/bragging rights
