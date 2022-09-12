pipeline {
    agent any
        stages {
            stage('Linting') {
                steps {
                    echo "Linting Dockerfile"
                    sh "/bin/hadolint Dockerfile"
                    echo "Linting html"
                    sh "tidy -q -e index.html"
                }
            }	
        }
}
