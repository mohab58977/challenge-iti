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
                    } else if ( env.BRANCH_NAME == 'dev') {
                       
                withCredentials([file(credentialsId: 'my', variable: 'my')]){

                    sh """
                            gcloud auth activate-service-account  my-service-account@project-for-mohab.iam.gserviceaccount.com --key-file="$my" --project=project-for-mohab
                            gcloud container clusters get-credentials app-cluster --region europe-west3 --project project-for-mohab
                            export BUILD_NUMBER=\$(cat ../build)
                             mv Deployment/deploy.yaml Deployment/deploy
                        cat Deployment/deploy | envsubst > Deployment/deploy.yaml
                        rm -f Deployment/deploy
                        cat Deployment/deploy.yaml 
                        kubectl apply -f Deployment/
                        """
                         } 
                      }
                } 

            }
        }


    
    }
}