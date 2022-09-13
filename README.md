# Udacity DevOps Cloud Engineer Capstone Project


## Objectives

- Working in AWS
- Using Jenkins or Circle CI to implement Continuous Integration and Continuous Deployment
- Building pipelines
- Working with Ansible and CloudFormation to deploy clusters
- Building Kubernetes clusters
- Building Docker containers in pipelines


## Prerequisites

All tools required for this project are listed below. I have also set up an [EC2 instance](screenshots/ec2Instance.jpg) which will host/communicate with these tools and essentially serve as the management centre for this project.
- Jenkins (incl. Blue Ocean plugin)
https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-22-04
- Docker
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04
- Kubernetes
https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html
- EKS
https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html
- AWS/AWS-CLI
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
- Github
To integrate with Jenkins https://www.cprime.com/resources/blog/how-to-integrate-jenkins-github/
- Hadolint
https://stackoverflow.com/questions/62369711/how-to-install-hadolint-on-ubuntu
- Tidy
```sudo apt install tidy```
- Bash


## Application Specification

A simple Nginx "Hello World" application defined by [index.html](index.html). The webpage will have a blue or green background depending on how the load balancer is configured.

## CI/CD Pipeline

![jenkinsFullPipeline.png](screenshots/jenkinsFullPipeline.jpg)

### Stage 1 - Linting

My linting stage contains two jobs: linting the docker file using hadolint and linting the html using tidy. A successful linting job is shown [here](screenshots/lintingSuccess.jpg). A failed linting job is shown [here](screenshots/lintingFailure.jpg) and can be triggered by adding some erroneous syntax to the docker file or html file.

### Stage 2 - Build Blue Image

This is done by calling my [run_docker.sh](scripts/run_docker.sh) script from the blue folder with the tag name as the argument.

### Stage 3 - Build Green Image

This is done by calling my [run_docker.sh](scripts/run_docker.sh) script from the green folder with the tag name as the argument.

### Stage 4 - Push Blue Image

This is done by calling my [upload_docker.sh](scripts/upload_docker.sh) script from the blue folder with the tag name, docker username and docker password respectively as the 3 arguments. Proof of a successful upload to the docker hub is shown [here](screenshots/dockerUpload.jpg). Also note that for this stage relies on docker [credential configuration](screenshots/jenkinsCreds.jpg) within jenkins.

### Stage 5 - Push Green Image

This is done by calling my [upload_docker.sh](scripts/upload_docker.sh) script from the green folder with the tag name, docker username and docker password respectively as the 3 arguments. Proof of a successful upload to the docker hub is shown [here](screenshots/dockerUpload.jpg). Also note that for this stage relies on docker [credential configuration](screenshots/jenkinsCreds.jpg) within jenkins.

### Stage 6 - Create Cluster

Deploys the cluster using EKS and cloud formation. This stage (and the remaining stages) rely on aws [credential configuration](screenshots/jenkinsCreds.jpg) within jenkins. The cluster status is shown [here](eksCluster.jpg) and the status of the pods are shown [here](screenshots/k8Resources.jpg).

### Stage 7 - Set K8s Context

Updates kubeconfig and configures kubectl from AWS EKS as shown [here](screenshots/configK8s.jpg).

### Stage 8 - Deploy Blue Container

Deploys a container using the docker image with tag=blue. Replication controller status is shown [here](screenshots/k8Resources.jpg).

### Stage 9 - Deploy Green Container

Deploys a container using the docker image with tag=green. Replication controller status is shown [here](screenshots/k8Resources.jpg).

### Stage 10 - Run Blue Service

Starts the blue service on the worker nodes. Status of services are shown [here](screenshots/k8Resources.jpg).

### Stage 11 - Run Green Service

Starts the green service on the worker nodes. Status of services are shown [here](screenshots/k8Resources.jpg).


## Testing Application

The application can be tested by using the DNS Name and Port the load balancer is running on - this information is shown [here](screenshots/loadBalancer.jpg). The last stage of the Jenkins pipeline is to run the green service so we can see the "Hello World" text with the green background.
![greenApp.jpg](screenshots/greenApp.jpg)
This can be easily changed by manually running the "Run Blue Service" command again.
```
kubectl apply -f ./k8s/blue/blue-controller.json
```
![blueApp.jpg](screenshots/blueApp.jpg)

