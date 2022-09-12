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
                    sh "./run_docker.sh capstone . "
                }
            }
            
            stage('Push Image') {
                steps {
                    withCredentials([UsernamePassword(credentialsId: 'dockerHub', usernameVariable: 'UNAME', passwordVariable: 'PWD')]) {
                        sh "./run_docker.sh capstone $UNAME $PWD. "
                    }
                }
            }
            
        }
}
