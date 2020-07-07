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
				    bat("\$(aws ecr get-login --no-include-email | sed 's|https://||')")
					docker.withRegistry(registry, 'ecr:us-east-1:awsCredential') {
					docker.image(dockerImage).push()
					}
				}
			}
		}
    }
}