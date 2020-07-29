pipeline {
  environment {
   registry = "ferozalla/ferozalla"
   registryCredential = 'ferozalla'
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
                    sh 'mvn clean install'
                }
            }
        }
		
		stage('Building image') {
			steps{
				script {
				    echo "${NAME}"
					echo "${VERSION}"
					dockerImage = docker.build "$NAME:$BUILD_NUMBER"
				}
			}
		}
		
		/*stage('Push Image') {
			steps{
				script {
					docker.withRegistry( '', registryCredential ) {
					dockerImage.push('v1')
					}
				}
			}
		}*/
		
		stage('deploy to K8S') {
			steps{
				withCredentials([file(credentialsId: 'kubec', variable: 'KUBECONFIG')]) {
						sh 'kubectl version --short --client'
						sh 'kubectl config view'
						//sh 'kubectl apply -f api-deployment.yaml'
						//sh 'kubectl apply -f api-service.yaml'
						sh 'helm uninstall test-deployment test-helm'
						sh 'kubectl get svc'
						sh 'kubectl get pod'
						sh 'helm ls'
						//sh 'helm uninstall test-deployment'
				}
			}
		}
    }
}