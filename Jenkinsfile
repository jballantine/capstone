pipeline {
    agent any
        stages {
            stage('Linting') {
                steps {
                    echo "Linting html"
                    sh "tidy -q -e *.html"
                }
                post {
                    always {
                        archiveArtifacts "hadolint_lint.txt"
                    }
                }
            }	
        }
}