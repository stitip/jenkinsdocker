pipeline {
  environment {
    registry = '164506192075.dkr.ecr.us-east-1.amazonaws.com/renewables-uai3036814-hybrid-arch-dev-ecr'
    registryCredential = 'awsCredential'
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
					docker.build('sampleimage')
				}
			}
		}
		
		stage('Deploy AWS') {
			steps{
				script {
					docker.withRegistry(registry, registryCredential) {
					docker.push('sampleimage').push('v7')
					}
				}
			}
		}
    }
}