 pipeline {
  environment {
    registry = '164506192075.dkr.ecr.us-east-1.amazonaws.com'
    registryCredential = 'awsCredential'
	Namespace = 'default'
	ImageName = 'test'
	version = 'latest'
	ECRCRED = 'ecr:us-east-1:tap_ecr'
	dockerImage = ''
  }
    agent any

    stages {
	
	     stage('image tag preparation') {
			steps{
				script {
                    version=bat 'git rev-parse --short HEAD'
					ImageName = ImageName + ":" +$version
				}
			}
		}
		 
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
					dockerImage = docker.build(ImageName)
					bat('docker tag dockerImage generated:v1')
				}
			}
		}
		
		stage('Deploy docker desktop kubernetes') {
			steps{
				script {
				    bat("ecrLogin.bat")
					bat('docker tag sampleimage:latest 164506192075.dkr.ecr.us-east-1.amazonaws.com/renewables-uai3036814-hybrid-arch-dev-ecr:sampleimage-v1')
					bat('docker push 164506192075.dkr.ecr.us-east-1.amazonaws.com/renewables-uai3036814-hybrid-arch-dev-ecr:sampleimage-v1')
				}
			}
		}
    }
}