pipeline{
    agent any
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
            post {
                failure{
                    echo "do something"
                }
            }
        }
        stage("Test (run and sanity)") {
            steps {
                script {
                    docker.image(DOCKER_IMAGE).withRun('-p 8000:8080') {
                        sh 'curl http://localhost:8000'
                    }
                }
            }
        }
        stage("Docker registry push") {
            steps {
                script {
                    docker.withRegistry('https://ghcr.io', 'github-registry-token') {
                        def image = docker.build(DOCKER_IMAGE)
                        image.push()
                    }
                }
            }
        }
        // CD
        stage("Staging deployment") {
            agent {
                label "staging"
            }
            steps {
                script {
                    docker.withRegistry('https://ghcr.io', 'github-registry-token') {
                        sh "docker pull ${DOCKER_IMAGE}"
                        sh "docker rm --force service"
                        sh "docker run -d -p 8080:8080 --name service ${DOCKER_IMAGE}"
                    }
                }
            }
        }
        stage("Staging testing") {
            agent {
                label "staging"
            }
            steps {
                sh 'curl http://localhost:8080'
            }
        }
        // Green - primary
        // Blue - secondary
        stage("Production deployment") {
            agent {
                label "production"
            }
            steps {
                input 'Approve the deployment'
                script {
                    docker.withRegistry('https://ghcr.io', 'github-registry-token') {
                        sh "docker pull ${DOCKER_IMAGE}"
                        // For fresh environment
                        echo "Creating green (and blue if needed) environments"
                        sh "docker create -p 80:8080 --name service-green ${DOCKER_IMAGE} || echo 'Container is already created'"
                        sh "docker create -p 80:8080 --name service-blue ${DOCKER_IMAGE} && docker start service-green || echo 'Container is already created'"
                    }
                    sh 'docker rm --force service-green'
                    sh 'docker start service-blue'
                    sh 'docker create -p 80:8080 --name service-green ${DOCKER_IMAGE}'
                    sh 'docker stop service-blue'
                    sh 'docker start service-green'
                    sh 'curl http://localhost:81'
                }
            }
            post {
                success{
                    sh 'docker rm --force service-blue'
                    sh 'docker create -p 8080:8080 --name service-blue ${DOCKER_IMAGE}'
                }
                failure{
                    sh 'docker stop service-green'
                    sh 'docker stop service-blue'
                }
            }
        }
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