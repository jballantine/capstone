pipeline {
    agent any
        stages {
        
            stage('Linting') {
                steps {
                    sh 'hadolint k8s/green/Dockerfile'
                    sh 'hadolint k8s/blue/Dockerfile'
                    sh 'tidy -q -e index.html'
                }
            }
            
            stage('Build Blue Image') {
                steps {
                    sh '''
                    cd k8s/blue
                    ./../../scripts/run_docker.sh capstoneBlue
                    '''
                }
            }
            
            stage('Build Green Image') {
                steps {
                    sh '''
                    cd k8s/green
                    ./../../scripts/run_docker.sh capstoneGreen
                    '''
                }
            }
            
            stage('Push Blue Image') {
                steps {
                    withCredentials([string(credentialsId: 'dockerCreds', variable: 'SECRET')]) {
                        '''
                        cd k8s/blue
                        ./../../scripts/upload_docker.sh capstoneBlue jballantine1 $SECRET
                        '''
                    }
                }
            }
            
            stage('Push Green Image') {
                steps {
                    withCredentials([string(credentialsId: 'dockerCreds', variable: 'SECRET')]) {
                        sh '''
                        cd k8s/green
                        ./../../scripts/upload_docker.sh capstoneGreen jballantine1 $SECRET
                        '''
                    }
                }
            }
            
            stage('Create Cluster') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh '''
                        eksctl create cluster \
                        --name capstone \
                        --region us-east-1 \
                        --zones us-east-1a \
                        --zones us-east-1b \
                        --zones us-east-1c \
                        --zones us-east-1d \
                        --zones us-east-1f \
                        --nodegroup-name workers \
                        --node-type t2.small \
                        --nodes 2 \
                        --nodes-min 1 \
                        --nodes-max 3 \
                        '''
                    }
                }
            }
            
            stage('Set K8s Context') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh '''
                        ./scripts/installKube.sh && export PATH=$PATH:$HOME/bin
                        aws eks update-kubeconfig --region us-east-1 --name capstone
                        kubectl config use-context arn:aws:eks:us-east-1:036467374758:cluster/capstone
                        '''
                    }
                }
            }
            
            stage ('Deploy Blue Container') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh '''
                        ./scripts/installKube.sh && export PATH=$PATH:$HOME/bin
                        kubectl apply -f ./k8s/blue/blue-controller.json
                        '''
                    }
                }
            }
            
            stage ('Deploy Green Container') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh '''
                        ./scripts/installKube.sh && export PATH=$PATH:$HOME/bin
                        kubectl apply -f ./k8s/green/green-controller.json
                        '''
                    }
                }
            }
            
            stage ('Run Blue Service') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh '''
                        ./scripts/installKube.sh && export PATH=$PATH:$HOME/bin
                        kubectl apply -f ./k8s/blue/blue-service.json
                        '''
                    }
                }
            }
            
            stage ('Run Green Service') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh '''
                        ./scripts/installKube.sh && export PATH=$PATH:$HOME/bin
                        kubectl apply -f ./k8s/green/green-service.json
                        ''' 
                    }
                }
            }
        
        }
}
