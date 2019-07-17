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
                echo 'Inicia build de imagen con Docker'
                sh 'docker build --file Dockerfile --tag $IMAGE_NAME:latest .'
                echo 'Se tagea la imagen con el nro de build'
                sh 'docker tag $IMAGE_NAME:latest $IMAGE_NAME:$IMAGE_VERSION'
                sh 'docker tag $IMAGE_NAME:latest $DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_VERSION'
                sh 'docker tag $IMAGE_NAME:latest $DOCKER_REGISTRY/$IMAGE_NAME:latest'
                echo 'Se sube la imagen al repositorio'
                script {
                    docker.withRegistry("https://$DOCKER_REGISTRY/", "$DOCKER_REGISTRY_CREDENTIALS") {
                        sh 'docker push $DOCKER_REGISTRY/$IMAGE_NAME:latest'
                        sh 'docker push $DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_VERSION'
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