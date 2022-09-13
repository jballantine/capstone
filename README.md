# Udacity DevOps Cloud Engineer Capstone Project


## Objectives

- Working in AWS
- Using Jenkins or Circle CI to implement Continuous Integration and Continuous Deployment
- Building pipelines
- Working with Ansible and CloudFormation to deploy clusters
- Building Kubernetes clusters
- Building Docker containers in pipelines


## Prerequisites

All tools required for this project are listed below. I have also set up an [EC2 instance](screenshots/screenshot1.jpg) which will host/communicate with these tools and essentially serve as the management centre for this project.
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

A simple Nginx "Hello World" application defined by index.html.

## CI/CD Pipeline

![jenkinsFullPipeline.png](screenshots/jenkinsFullPipeline.png)

### Stage 1 - Linting