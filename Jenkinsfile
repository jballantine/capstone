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
                    withCredentials([UsernamePassword(credentialsId: 'dockerHub', usernameVariable: 'UNAME', passwordVariable: 'PWD')]) {
                        echo "Hi"
                    }
                }
            }
            
            stage('Push Image') {
                steps {
                    withCredentials([UsernamePassword(credentialsId: 'dockerHub', usernameVariable: 'UNAME', passwordVariable: 'PWD')]) {
                        echo "Hi"
                    }
                }
            }
            
        }
}
