pipeline {
    agent { label 'agent' }
    environment {
        dockerhub=credentials('Docker_Hub')
    }
    stages {
        stage('Build & Deploy') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'master') {
                        sh """
                        docker login -u $dockerhub_USR -p $dockerhub_PSW
                        docker build -t mohab5897/app:$BUILD_NUMBER .
                        docker push mohab5897/app:$BUILD_NUMBER
                        echo ${BUILD_NUMBER} > ../build
                        """
                    } else if (env.BRANCH_NAME == 'stage' || env.BRANCH_NAME == 'dev' || env.BRANCH_NAME == 'test') {
                        withCredentials([file(credentialsId: 'cfg', variable: 'cfg')]){
                        sh """
                            export BUILD_NUMBER=\$(cat ../build)
                       
                        mv Deployment/deploy.yaml Deployment/deploy
                        cat Deployment/deploy | envsubst > Deployment/deploy.yaml
                        rm -f Deployment/deploy
                        kubectl apply --kubeconfig=${cfg} -f Deployment/
                        """
                        } 
                      }
                } 

            }
        }


    
    }
}