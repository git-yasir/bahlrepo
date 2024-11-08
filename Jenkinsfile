pipeline {
    agent any 
    
    environment {     
    DOCKERHUB_CREDENTIALS= credentials('DockerHubCredentials')     
    }   
    stages{
        stage("Clone Code"){
            steps {
                echo "Cloning the code"
                git url:"https://github.com/git-yasir/bahlrepo.git", branch: "main"
                echo "**************************************************************************************************************"
            }
        }
        stage("Build"){
            steps {
                echo "Building the image"
                sh "docker build -t bahl-app ."
                echo "**************************************************************************************************************"
            }
        }

        stage('Login to Docker Hub') {         
            steps{                            
            sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'                 
            echo 'Login Completed'                
            }           
        }               


        stage("Push to Docker Hub"){
            steps {
                echo "Pushing the image to docker hub"
                sh "docker tag bahl-app yasirdocker/bahl-app:latest"
                sh "docker push yasirdocker/bahl-app:latest"
                echo "**************************************************************************************************************"
            }
        }

        stage("Delete Existing Deployment") {
            steps {
                script {
                    def deploymentExists = sh(script: "sudo -u ubuntu kubectl get deployment bahldeploy", returnStatus: true) == 0
                    def serviceExists = sh(script: "sudo -u ubuntu kubectl get svc bahl-appsvc ", returnStatus: true) == 0
                    
                    if (deploymentExists) {
                        echo "Deleting the Existing Deployment"
                        sh "sudo -u ubuntu kubectl delete deployment bahldeploy"
                    } else {
                        echo "No existing deployment found. Skipping deletion."
                    }

                    if (serviceExists) {
                        echo "Deleting the Existing Service"
                        sh "sudo -u ubuntu kubectl delete svc bahl-appsvc "
                    } else {
                        echo "No existing service found. Skipping deletion."
                    }
                }
                echo "**************************************************************************************************************"   
            }
        }



        stage("Deploy"){
            steps {
                echo "Deploying the container"
                sh "sudo -u ubuntu kubectl get pods"
                sh "sudo -u ubuntu kubectl create -f deployment.yaml"
                echo "**************************************************************************************************************"
                
            }
        }
    }
}


