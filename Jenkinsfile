pipeline{
    environment {
        DOCKER_IMAGE = "ghcr.io/dos06-onl/application-example:${env.BUILD_ID}"
    }
    stages{
        // CI
        stage("Build") {
            steps {
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
            post{
                failure{
                    echo "do something"
                }
            }
        }
        stage("Test (run and sanity)") {
            agent {
                docker { image DOCKER_IMAGE }
            }
            steps {
                sh 'id'
                sh 'cat /opt/www/index.html'
                sh '/usr/sbin/nginx -t'
            }
        }
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