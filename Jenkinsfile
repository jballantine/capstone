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
            
            stage('Set K8s Context') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials', roleAccount:'036467374758', role:'admin') {
                        sh '''
                        aws eks --region "us-east-1" update-kubeconfig --name "capstone"
                        kubectl get nodes
                        kubectl get all
                        # kubectl config use-context arn:aws:eks:us-east-1:036467374758:cluster/capstone
                        '''
                    }
                }
            }
/*            
            stage ('Deploy blue container') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh 'kubectl apply -f ./blue-controller.json'
                    }
                }
            }
            
            stage ('Deploy green container') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh 'kubectl apply -f ./green-controller.json' 
                    }
                }
            }
            
            stage ('Run blue service') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh 'kubectl apply -f ./blue-service.json' 
                    }
                }
            }
            
            stage ('Run green service') {
                steps {
                    withAWS(region: 'us-east-1', credentials: 'aws-credentials') {
                        sh 'kubectl apply -f ./green-service.json' 
                    }
                }
            }
*/            
        }
}
