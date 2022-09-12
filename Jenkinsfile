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
                    withCredentials([usernamePassword(credentialsId: 'dockerHub', usernameVariable: 'UNAME', passwordVariable: 'PWD')]) {
                        whoami
                        sh "docker images"
                        sh "./run_docker.sh capstone"
                    }
                }
            }
            
            stage('Push Image') {
                steps {
                    withCredentials([usernamePassword(credentialsId: 'dockerHub', usernameVariable: 'UNAME', passwordVariable: 'PWD')]) {
                        sh "./run_docker.sh capstone $UNAME $PWD"
                    }
                }
            }
            
        }
}
