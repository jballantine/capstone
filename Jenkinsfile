pipeline {
    agent any
        stages {
        
            stage('Linting') {
                steps {
                    echo 'Linting Dockerfile'
                    sh 'hadolint Dockerfile'
                    echo 'Linting html'
                    sh 'tidy -q -e index.html'
                }
            }
            
            stage('Build Image') {
                steps {
                    sh './scripts/run_docker.sh capstone'
                }
            }
            
            stage('Push Image') {
                steps {
                    withCredentials([string(credentialsId: 'dockerCreds', variable: 'SECRET')]) {
                        sh './scripts/upload_docker.sh capstone jballantine1 $SECRET'
                    }
                }
            }
/*            
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
*/            
            stage('Set K8s Context') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh '''
                        ./scripts/installKube.sh && export PATH=$PATH:$HOME/bin
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
                        kubectl apply -f ./k8s/blue-controller.json
                        '''
                    }
                }
            }
            
            stage ('Deploy Green Container') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh '''
                        ./scripts/installKube.sh && export PATH=$PATH:$HOME/bin
                        kubectl apply -f ./k8s/green-controller.json
                        '''
                    }
                }
            }
            
            stage ('Run Blue Service') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh '''
                        ./scripts/installKube.sh && export PATH=$PATH:$HOME/bin
                        kubectl apply -f ./k8s/blue-service.json
                        '''
                    }
                }
            }
            
            stage ('Run Green Service') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh '''
                        ./scripts/installKube.sh && export PATH=$PATH:$HOME/bin
                        kubectl apply -f ./k8s/green-service.json
                        ''' 
                    }
                }
            }
        
        }
}
