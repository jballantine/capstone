pipeline {
    agent any
        stages {
        
            stage('Linting') {
                steps {
                    echo "Linting Dockerfile"
                    sh "hadolint Dockerfile"
                    echo "Linting html"
                    sh "tidy -q -e index.html"
                }
            }
            
            stage('Build Image') {
                steps {
                        sh "./run_docker.sh capstone"
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
                    withAWS(region: 'us-east-1', credentials: 'capstone') {
                        sh "kubectl config use-context arn:aws:eks:us-east-1:036467374758:cluster/capstone"
                    }
                }
            }
            
        }
}
