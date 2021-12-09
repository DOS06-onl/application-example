pipeline{
    agent {
        label "ssh"
    }
    stages{
        // CI
        stage("Code analysis") {
            agent { docker { image "ghcr.io/hadolint/hadolint:latest" } }
            steps {
                hadolint Dockerfile
            }
        }
        // stage("Build") {}
        // stage("Test (run and sanity)") {}
        // stage("Docker registry push") {}
        // // CD
        // stage("Staging deployment") {}
        // stage("Staging testing") {}
        // stage("Production approve") {}
        // stage("Production deployment") {}
        // stage("Production testing") {}
    }
    post{
        always{
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}