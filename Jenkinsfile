pipeline {
    agent any
        stages {
            stage('Linting') {
                steps {
                    echo "Linting Dockerfile"
                    sh "/bin/hadolint Dockerfile"
                    echo "Linting html"
                    sh "/bin/tidy -q -e *.html"
                }
                post {
                    always {
                        archiveArtifacts "hadolint_lint.txt"
                    }
                }
            }	
        }
}