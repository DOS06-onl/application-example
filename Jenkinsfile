pipeline{
    agent {
        label "ssh"
    }
    stages{
        // CI
        stage("Build") {
            steps {
                script {
                    docker.build("ghcr.io/dos06-onl/application-example:${env.BUILD_ID}")
                }
            }
        }
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