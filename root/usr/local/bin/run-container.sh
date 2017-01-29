#!/bin/bash

chown -R jenkins:jenkins /home/jenkins

exec su --preserve-environment -c "/usr/bin/java -jar \
  /usr/local/bin/swarm-client.jar \
  -master ${JENKINS_MASTER} \
  -username ${JENKINS_USERNAME} \
  -passwordEnvVariable JENKINS_PASSWORD \
  -executors ${JENKINS_EXECUTORS} \
  -labels "${JENKINS_LABELS}" \
  -fsroot /home/jenkins" \
  jenkins
