pipeline {
    agent any
    
    environment {
        // Change these variables as needed
        DOCKER_IMAGE = "ayenioluwadamilare/portfolio"
        DOCKER_TAG = "${BUILD_NUMBER}"
        // If you're using DockerHub or other registry that needs authentication
        DOCKER_CREDENTIALS_ID = 'docker-credentials'
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Get code from GitHub repository
                checkout scm
                echo 'Code checkout complete'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                    sh "docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:latest"
                    echo 'Docker image build complete'
                }
            }
        }
        
        stage('Test') {
            steps {
                script {
                    // Simple test to verify the container starts properly
                    sh "docker run -d --name portfolio-test -p 8080:80 ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    sh "sleep 5" // Wait for container to fully start
                    sh "curl -s http://localhost:8080 > /dev/null && echo 'Website is accessible' || (echo 'Website test failed' && exit 1)"
                    sh "docker stop portfolio-test"
                    sh "docker rm portfolio-test"
                    echo 'Testing complete'
                }
            }
        }
        
        stage('Push to Registry') {
            steps {
                script {
                    // Push the Docker image to the registry (e.g., DockerHub)
                    docker.withRegistry('https://registry.hub.docker.com', DOCKER_CREDENTIALS_ID) {
                        sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                        sh "docker push ${DOCKER_IMAGE}:latest"
                    }
                    echo 'Docker image push complete'
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    // SSH into your server and deploy the new container
                    // This is a simplified example - you might use Docker Compose or other tools
                    sshagent(['deployment-server']) {
                        sh """
                            ssh user@your-server.com <<EOF
                            docker pull ${DOCKER_IMAGE}:latest
                            docker stop portfolio || true
                            docker rm portfolio || true
                            docker run -d --name portfolio -p 80:80 ${DOCKER_IMAGE}:latest
                            EOF
                        """
                    }
                    echo 'Deployment complete'
                }
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline execution failed!'
        }
        always {
            // Clean up local Docker images to save space
            sh "docker rmi ${DOCKER_IMAGE}:${DOCKER_TAG} || true"
            sh "docker rmi ${DOCKER_IMAGE}:latest || true"
        }
    }
}
