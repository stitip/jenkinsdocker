pipeline {
  environment {
    registry = '164506192075.dkr.ecr.us-east-1.amazonaws.com'
    registryCredential = 'awsCredential'
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
					dockerImage = docker.build('sampleimage')
				}
			}
		}
		
		stage('Deploy AWS') {
			steps{
				script {
				    bat("aws configure")
					docker.withRegistry(registry, 'ecr:us-east-1:registryCredential') {
					docker.image(dockerImage).push()
					}
				}
			}
		}
    }
}