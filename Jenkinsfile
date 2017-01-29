#!groovy

node('rpi3') {
  stage('Checkout') {
    checkout scm
  }

  stage('Build') {
    sh 'docker build -t armhero/jenkins-slave:\044{BRANCH_NAME} .'
  }

  stage('Push') {
    withCredentials([
      usernamePassword(credentialsId: '1d448f61-46d6-4af8-a517-9a06866447bb',
      passwordVariable: 'DOCKER_PASSWORD',
      usernameVariable: 'DOCKER_USERNAME')
    ]) {
      sh '''#!/bin/bash -xe
        docker login -u \044{DOCKER_USERNAME} -p \044{DOCKER_PASSWORD}

        if [[ "\044{BRANCH_NAME}" == "master" ]]; then
          # when we are in the master branch, then set a new tag
          docker tag armhero/jenkins-slave:\044{BRANCH_NAME} armhero/jenkins-slave:latest

          docker push armhero/jenkins-slave:latest
          docker rmi armhero/jenkins-slave:latest
        else
          docker push armhero/jenkins-slave:${BRANCH_NAME}
        fi

        docker rmi armhero/jenkins-slave:${BRANCH_NAME} || true

        # update badges
        curl -X POST https://hooks.microbadger.com/images/armhero/jenkins-slave/3dhbMdncwMdmcxkk8q3UH0FCLl4=
      '''
    }
  }
}
