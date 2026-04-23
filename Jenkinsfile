pipeline {
    agent any
    
    environment {
        PROJECT_DIR = '/home/govind-19364/Devops/react_deployment/devops-build'
    }
    
    stages {
        stage('Build') {
            steps {
                sh '''
                    cd $PROJECT_DIR
                    ./build.sh
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
                        cd $PROJECT_DIR
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
                    cd $PROJECT_DIR
                    ./deploy.sh
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

