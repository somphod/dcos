# arca-mimo

**Instructors**
- Ben Lin, ben.lin@mesosphere.com
- Sam Chen, schen.c@mesosphere.com

**ARCA Survey**  
- http://bit.ly/297EfIj

**DC/OS Slack channel**
- chat.dcos.io7

**Prerequisites**
- Download the DC/OS CLI Binary to suit your OS:
https://github.com/dcos/dcos-cli/releases/

- Clone the arca git repository  
```git clone https://github.com/mesosphere/arca-mimo.git```

**DC/OS CLI Setup**
- Change cluster url to point to your designated cluster on the spreadsheet
```dcos cluster setup https://<master-ip>```
- Accept the cert
- Login to cluster (user/pass is ```bootstrapuser/deleteme```)  
- List the DC/OS Agent Nodes to verify cluster connectivity
```dcos node```
- List the DC/OS Packages available for installation from Universe
```dcos package search```

**Highly Recommended MesosCon Talks**
- Building Highly Available Mesos Frameworks by Neil Conway, Mesosphere
https://www.youtube.com/watch?v=rvX0P4elmmc&index=34&list=PLGeM09tlguZQVL7ZsfNMffX9h1rGNVqnC
- Resource Allocation in Apache Mesos - Present and Future - Benjamin Mahler, Mesosphere
https://www.youtube.com/watch?v=drvmaasBI4k&index=47&list=PLGeM09tlguZQVL7ZsfNMffX9h1rGNVqnC
- Containers in Apache Mesos - Present and Future
https://www.youtube.com/watch?v=rHUngcGgzVM&index=14&list=PLGeM09tlguZQVL7ZsfNMffX9h1rGNVqnC
- A Declarative Approach to Building Stateful Frameworks - Gabriel Hartman, Mesosphere
https://www.youtube.com/watch?v=1DUoDlEA-qs&index=38&list=PLGeM09tlguZQVL7ZsfNMffX9h1rGNVqnC
- Quota - Reliable Guarantees - Jörg Schad & Joris Van Remoortere, Mesosphere
https://www.youtube.com/watch?v=K0MF7tJQXqk&index=45&list=PLGeM09tlguZQVL7ZsfNMffX9h1rGNVqnC
- Persistence Primitives in Action 2.0
https://www.youtube.com/watch?v=9VS9Oq_d5NM&index=50&list=PLGeM09tlguZQVL7ZsfNMffX9h1rGNVqnC
- Container Network Interface (CNI) Support in Apache Mesos
https://www.youtube.com/watch?v=0UMCoojACOs&index=18&list=PLGeM09tlguZQVL7ZsfNMffX9h1rGNVqnC
- Frameworks in Harmony - How to Implement Quotas, Roles, Weights and Reservations in Production
https://www.youtube.com/watch?v=smN0yUY1ZQU&list=PLGeM09tlguZQVL7ZsfNMffX9h1rGNVqnC&index=30
- Running Cassandra on Apache Mesos Across Multiple Datacenters at Uber
https://www.youtube.com/watch?v=U2jFLx8NNro&index=25&list=PLGeM09tlguZQVL7ZsfNMffX9h1rGNVqnC

**Additional Resources**
- Container 101 Lab  
https://github.com/mesosphere/training/tree/master/velocity-training-06-2016/container101
- Troubleshooting  
https://github.com/mesosphere/training/tree/master/velocity-training-06-2016/troubleshooting
