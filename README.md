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


## Application

A simple Nginx "Hello World" application defined by [index.html](index.html).

## CI/CD Pipeline

![jenkinsFullPipeline.png](screenshots/jenkinsFullPipeline.png)

### Stage 1 - Linting

My linting stage contains two jobs: linting the docker file using hadolint and linting the html using tidy. A successful linting job is shown [here](screenshots/lintingSuccess.jpg). A failed linting job is shown [here](screenshots/lintingFailure.jpg) and can be triggered by adding some erroneous syntax to the docker file or html file.

### Stage 2 - Build image

This is done by calling my [run_docker.sh](scripts/run_docker.sh) script with the tag name as the argument.

### Stage 3 - Upload image

This is done by calling my [upload_docker.sh](scripts/upload_docker.sh) script with the tag name, docker username and docker password respectively as the 3 arguments. Proof of a successful upload to the docker hub is shown [here](screenshots/dockerUpload.jpg). Also note that for this stage relies on docker [credential configuration](screenshots/jenkinsCreds) within jenkins.

### Stage 4 - Create Cluster

Deploys the cluster using EKS and cloud formation. This stage (and the remaining stages) rely on aws [credential configuration](screenshots/jenkinsCreds) within jenkins.

### Stage 5 - Set K8s Context

Configures kubectl from AWS EKS as shown [here](screenshots/configK8s).

### Stage 6 - Deploy co

