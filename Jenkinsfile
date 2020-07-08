pipeline {
  environment {
    registry = '164506192075.dkr.ecr.us-east-1.amazonaws.com'
    registryCredential = 'awsCredential'
	ECRCRED = 'ecr:us-east-1:tap_ecr'
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
					bat 'aws configure set aws_access_key_id ASIASMTKVJDFZYK3IHHU'
                    bat 'aws configure set aws_secret_access_key R4a5zYYG2kHmJUC8J9M84mzpHnLjpTJuedMv/uWb'
					docker.withRegistry(registry, ECRCRED) {
					docker.image(dockerImage).push()
					}
				}
			}
		}
    }
}