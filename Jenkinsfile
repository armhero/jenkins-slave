#!groovy

node('rpi3') {
  stage('Checkout') {
    checkout scm
  }

  stage('Build') {
    sh 'env'
    sh 'docker build -t armhero/jenkins-slave:${BRANCH} .'
  }

  stage('Push') {
    withCredentials([
      usernamePassword(credentialsId: '1d448f61-46d6-4af8-a517-9a06866447bb',
      passwordVariable: 'DOCKER_PASSWORD',
      usernameVariable: 'DOCKER_USERNAME')
    ]) {
      sh '''
        docker login -u \044{DOCKER_USERNAME} -p \044{DOCKER_PASSWORD}

        if [ "$BRANCH" == "master" ]; then
          # when we are in the master branch, then set a new tag
          docker tag armhero/jenkins-slave:${BRANCH} armhero/jenkins-slave:latest

          docker push armhero/jenkins-slave:latest
          docker rmi armhero/jenkins-slave:latest
        else
          docker push armhero/jenkins-slave:${BRANCH}
        fi

        docker rmi armhero/jenkins-slave:${BRANCH}
      '''
    }
  }
}
