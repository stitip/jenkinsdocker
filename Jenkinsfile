pipeline {
  environment {
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
		
		stage('deploy image') {
			steps{
				kubernetesDeploy(
            configs: 'myweb.yaml',
            kubeconfigId: 'clusterkubeconfig',
            enableConfigSubstitution: true
        )
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
		
    }
}