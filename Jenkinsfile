pipeline {
    agent any
    
    stages {
        stage('Debug') {
            steps {
                sh '''
                    echo "Current directory:"
                    pwd
                    echo "Files in workspace:"
                    ls -la
                    echo "Dockerfile contents:"
                    cat Dockerfile
                '''
            }
        }
        
        stage('Build') {
            steps {
                sh '''
                    chmod +x build.sh
                    bash build.sh
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
