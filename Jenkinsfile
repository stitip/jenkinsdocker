pipeline {
  environment {
    registry = "ferozalla/ferozalla"
    registryCredential = 'ferozalla'
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
					docker.build registry + ":$BUILD_NUMBER"
				}
			}
		}
    }
}