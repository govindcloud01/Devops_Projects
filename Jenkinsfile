pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t react-devops-app -f $WORKSPACE/Dockerfile $WORKSPACE'
                sh 'docker tag react-devops-app govindcloud01/dev:latest'
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
                        echo "Current branch: $GIT_BRANCH"
                        if [ "$GIT_BRANCH" = "origin/dev" ]; then
                            echo "Pushing to dev repo..."
                            docker push govindcloud01/dev:latest
                        elif [ "$GIT_BRANCH" = "origin/master" ] || [ "$GIT_BRANCH" = "origin/main" ]; then
                            echo "Pushing to prod repo..."
                            docker tag react-devops-app govindcloud01/prod:latest
                            docker push govindcloud01/prod:latest
                        else
                            echo "Branch is: $GIT_BRANCH - pushing to dev by default"
                            docker push govindcloud01/dev:latest
                        fi
                    '''
                }
            }
        }
        
        stage('Deploy') {
            steps {
                sh 'bash $WORKSPACE/deploy.sh'
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
