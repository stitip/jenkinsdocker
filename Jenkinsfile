pipeline {
  environment {
   NAME = "myapp"
   VERSION = "${env.BUILD_ID}-${env.GIT_COMMIT}"
   IMAGE = "${NAME}:${VERSION}"
   ECR = 'kubernetes'
	dockerImage = ''
  }
    agent any

    stages {
        stage ('Compile Stage') {

            steps {
                withMaven(maven : 'MavenLocal') {
                    bat 'mvn clean install'
                }
            }
        }
		
		stage('Building image') {
			steps{
				script {
				    echo "${NAME}"
					echo "${VERSION}"
					dockerImage = docker.build "$NAME:$BUILD_NUMBER"
					bat 'kubectl get pod'
					//dockerImage.push(VERSION)
				}
			}
		}
		stage ('Deployment in Kubernetes') {

            steps {
                  script {
				    bat 'kubectl apply -f D:\GEGDC\SF675345\poc\kubernetes\demo\api-deployment.yaml'
                    bat 'kubectl set image deployments/demo-api-svc test-kube-deployment-container="$NAME:$BUILD_NUMBER" --record'
                }
            }
        }
    }
}