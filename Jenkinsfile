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
				    bat("aws ecr get-login --no-include-email --region us-east-1 | clip")
					bat('docker tag sampleimage:latest 164506192075.dkr.ecr.us-east-1.amazonaws.com/sampleimage:latest')
					bat('docker push 164506192075.dkr.ecr.us-east-1.amazonaws.com/sampleimage:latest')
				}
			}
		}
    }
}