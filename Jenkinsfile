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
/*            
            stage('Create cluster') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh 'eksctl create cluster --name capstone --region us-east-1 --nodegroup-name workers --node-type t2.small --nodes 2 --nodes-min 1 --nodes-max 3'
                    }
                }
            }
*/            
            stage('Set K8s Context') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh '''
                        curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.23.7/2022-06-29/bin/linux/amd64/kubectl
                        chmod +x ./kubectl
                        mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
                        echo $HOME
                        echo $PATH
                        pwd
                        kubectl get nodes
                        kubectl get all
                        kubectl config use-context arn:aws:eks:us-east-1:036467374758:cluster/capstone
                        '''
                    }
                }
            }
/*            
            stage ('Deploy blue container') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh '''
                        script {installKube ()}
                        kubectl apply -f ./blue-controller.json
                        '''
                    }
                }
            }
            
            stage ('Deploy green container') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh '''
                        script {installKube ()}
                        kubectl apply -f ./green-controller.json
                        '''
                    }
                }
            }
            
            stage ('Run blue service') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh '''
                        script {installKube ()}
                        kubectl apply -f ./blue-service.json
                        '''
                    }
                }
            }
            
            stage ('Run green service') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh '''
                        script {installKube ()}
                        kubectl apply -f ./green-service.json
                        ''' 
                    }
                }
            }
*/         
        }
}
