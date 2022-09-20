node {
	def app = 'diary'
	def img

/*	stage('Clean up') {
		sh "~/cleanup.sh ${app}"
	}
*/
	stage('Building image') {
		img = docker.build("${app}:${env.BUILD_ID}")
	}
	stage('Test image') {
		img.inside { sh 'java -version' }
	}
	stage('Push image into registry') {
		docker.withRegistry('https://portainer.flexpay.com.ua/v2/', 'private_registry') {
			img.push("latest")
		}
	}
}
