pipeline{
    agent {
        label "ssh"
    }
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
        }
        stage("Test (run and sanity)") {
            steps {
                script {
                    docker.image(DOCKER_IMAGE).inside('-u 1:1') {
                        sh 'cat /opt/www/index.html'
                        sh '/usr/sbin/nginx -t'
                    }
                }
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