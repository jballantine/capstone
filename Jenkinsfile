pipeline {
    agent any
        stages {
            stage('Linting') {
                steps {
                    echo "Linting html"
                    sh "tidy -q -e *.html"
                    echo "Linting dockerfile"
                    sh "hadolint dockerfiles/* | tee -a hadolint_lint.txt"
                    echo pwd
                    echo ls
                }
                post {
                    always {
                        archiveArtifacts "hadolint_lint.txt"
                    }
                }
            }	
        }
}