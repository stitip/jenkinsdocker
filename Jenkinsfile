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
				    bat('aws configure set aws_access_key_id ASIASMTKVJDFUSKRNKZG')
					bat('aws configure set aws_secret_access_key 2Muo3/5joG6bQT4n8w6PL46Ch5j2uZ7jSWdTDeBz')
					bat('docker tag sampleimage:latest 164506192075.dkr.ecr.us-east-1.amazonaws.com/renewables-uai3036814-hybrid-arch-dev-ecr:sampleimage-v1')
					bat('docker push 164506192075.dkr.ecr.us-east-1.amazonaws.com/renewables-uai3036814-hybrid-arch-dev-ecr:sampleimage-v1')
				}
			}
		}
    }
}