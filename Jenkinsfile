pipeline {
    agent any
    stages {
        stage('Building') {
            environment { 
                    DOCKER_REGISTRY = 'hub.docker.com'
                    DOCKER_REGISTRY_CREDENTIALS = 'docker-credentials'
                    IMAGE_NAME = "marine789/nginx-with-certbot"
                    IMAGE_VERSION = "${currentBuild.startTimeInMillis}"
                }
            steps {
                script {
                    echo 'Inicia build de imagen con Docker'
                    def image = docker.build("${IMAGE_NAME}:${IMAGE_VERSION}", "./")
                    echo 'Se sube la imagen al repositorio'
                    docker.withRegistry("https://$DOCKER_REGISTRY/", "$DOCKER_REGISTRY_CREDENTIALS") {
                        image.push()
                        image.push("latest")
                    }
                }
            }
            post{
                always{
                    echo "========always========"
                }
                success{
                    echo "========stage executed successfully ========"
                }
                failure{
                    echo "========stage execution failed========"
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