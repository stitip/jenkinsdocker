pipeline {
  environment {
    registry = "ferozalla/ferozalla"
    registryCredential = 'ferozalla'
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
					dockerImage = docker.build registry + ":$BUILD_NUMBER"
				}
			}
		}
		
		stage('Deploy Image') {
			steps{
				script {
					docker.withRegistry( '', registryCredential ) {
					dockerImage.push()
					}
				}
			}
		}
    }
}