pipeline {
    agent any
    
    stages {
        stage('Clone') {
            steps {
                git branch: 'dev',
                    credentialsId: 'github-creds',
                    url: 'https://github.com/govindcloud01/Devops_Projects.git'
            }
        }
        
        stage('Build') {
            steps {
                sh '''
                    chmod +x build.sh
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
