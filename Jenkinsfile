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
					bat 'kubectl get pods'
                }
            }
        }
		
		stage('Building image') {
			steps{
				script {
				    echo "${NAME}"
					echo "${VERSION}"
					dockerImage = docker.build "$NAME:$BUILD_NUMBER"
					//dockerImage.push(VERSION)
				}
			}
		}
		
    }
}