pipeline {
  environment {
   registry = "ferozalla/ferozalla"
   registryCredential = 'ferozalla'
   NAME = "myapp"
   VERSION = "${env.BUILD_ID}-${env.GIT_COMMIT}"
   IMAGE = "${NAME}:${VERSION}"
   ECR = 'kubernetes'
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
				    echo "${NAME}"
					echo "${VERSION}"
					dockerImage = docker.build "$NAME:$BUILD_NUMBER"
				}
			}
		}
		
		/*stage('Push Image') {
			steps{
				script {
					docker.withRegistry( '', registryCredential ) {
					dockerImage.push('v1')
					}
				}
			}
		}*/
		
		stage('deploy to K8S') {
			steps{
				kubernetesDeploy(configs: 'myservice.yaml',kubeconfigId: 'clusterkubeconfig',enableConfigSubstitution: true)
			}
		}
    }
}