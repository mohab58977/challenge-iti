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
                       
                withCredentials([file(credentialsId: 'my', variable: 'my')]){

                    sh """
                            gcloud auth activate-service-account  my-service-account@project-for-mohab.iam.gserviceaccount.com --key-file="$my" --project=project-for-mohab
                            gcloud container clusters get-credentials app-cluster --region europe-west3 --project project-for-mohab
                            export BUILD_NUMBER=\$(cat ../build)
                           sed -i 's/BUILD_NUMBER/${env.BUILD_NUMBER}/g' Deployment/app.yaml
y
                        kubectl apply -f Deployment/
                        """
                         } 
                      }
                } 

            }
        }


    
    }
}