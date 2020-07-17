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
					docker.build ":$NAME"
					bat 'docker tag ${NAME}:latest ${ECR}/${NAME}:${VERSION}'
				}
			}
		}
    }
}