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
                        sh './run_docker.sh capstone'
                }
            }
            
            stage('Push Image') {
                steps {
                    withCredentials([usernamePassword(credentialsId: 'dockerHub', usernameVariable: 'UNAME', passwordVariable: 'PWD')]) {
                        sh '''
                        echo Skipping
                        # ./upload_docker.sh capstone $UNAME $PWD
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
                        ./installKube.sh && export PATH=$PATH:$HOME/bin
                        kubectl get nodes
                        kubectl get all
                        kubectl config use-context arn:aws:eks:us-east-1:036467374758:cluster/capstone
                        '''
                    }
                }
            }
            
            stage ('Deploy Blue Container') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh '''
                        ./installKube.sh && export PATH=$PATH:$HOME/bin
                        kubectl apply -f ./blue-controller.json
                        '''
                    }
                }
            }
            
            stage ('Deploy Green Container') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh '''
                        ./installKube.sh && export PATH=$PATH:$HOME/bin
                        kubectl apply -f ./green-controller.json
                        '''
                    }
                }
            }
            
            stage ('Run Blue Service') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh '''
                        ./installKube.sh && export PATH=$PATH:$HOME/bin
                        kubectl apply -f ./blue-service.json
                        '''
                    }
                }
            }
            
            stage ('Run Green Service') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh '''
                        ./installKube.sh && export PATH=$PATH:$HOME/bin
                        kubectl apply -f ./green-service.json
                        ''' 
                    }
                }
            }
        
        }
}
