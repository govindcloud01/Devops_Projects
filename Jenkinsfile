pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh '''
                    cp -r /home/ubuntu/.jenkins/workspace/react-devops-pipeline /tmp/docker-build
                    cd /tmp/docker-build
                    docker build -t react-devops-app .
                    docker tag react-devops-app govindcloud01/dev:latest
                    rm -rf /tmp/docker-build
                '''
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        if [ "$GIT_BRANCH" = "origin/dev" ]; then
                            docker push govindcloud01/dev:latest
                        elif [ "$GIT_BRANCH" = "origin/master" ]; then
                            docker tag react-devops-app govindcloud01/prod:latest
                            docker push govindcloud01/prod:latest
                        fi
                    '''
                }
            }
        }
        
        stage('Deploy') {
            steps {
                sh '''
                    chmod +x deploy.sh
                    bash deploy.sh
                '''
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
