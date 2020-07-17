pipeline {
  environment {
    registry = '164506192075.dkr.ecr.us-east-1.amazonaws.com'
    registryCredential = 'awsCredential'
	dockerImage = ''
	version = 'latest'
	IMAGE = ''
	PROJECT = 'test'
  }
    agent any

    stages {
        stage ('Compile Stage') {

            steps {
                withMaven(maven : 'MavenLocal') {
                    sh 'mvn clean install'
                }
            }
        }
		
		stage('image tag preparations')
        {
            steps
            {
                script 
                {
                    // calculate GIT lastest commit short-hash
                    gitCommitHash = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
					echo "$gitCommitHash"
                    shortCommitHash = gitCommitHash.take(7)
					echo "$shortCommitHash"
                    // calculate a sample version tag
                    version = shortCommitHash
					echo "$version"
                    // set the build display name
                    currentBuild.displayName = "#${BUILD_ID}-${version}"
					echo "$currentBuild.displayName"
                    IMAGE = "$PROJECT:$version"
					echo "$IMAGE"
					
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
				    sh("eval \$(aws ecr get-login --no-include-email | sed 's|https://||')")
					sh('docker tag sampleimage:latest 164506192075.dkr.ecr.us-east-1.amazonaws.com/renewables-uai3036814-hybrid-arch-dev-ecr:sampleimage-v1')
					sh('docker push 164506192075.dkr.ecr.us-east-1.amazonaws.com/renewables-uai3036814-hybrid-arch-dev-ecr:sampleimage-v1')
				}
			}
		}
    }
}