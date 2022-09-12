pipeline {
    agent any
        stages {
            stage('Linting') {
                agent {
                    docker {
                        image 'hadolint/hadolint:latest-debian'
                    }
                }
                steps {
                    echo "Linting html"
                    sh "tidy -q -e *.html"
                    echo "Linting dockerfile"
                    sh "hadolint dockerfiles/* | tee -a hadolint_lint.txt"
                }
                post {
                    always {
                        archiveArtifacts "hadolint_lint.txt"
                    }
                }
            }	
        }
}