FROM armhero/raspbian:jessie

ENV JENKINS_MASTER=https://example.org \
  JENKINS_USERNAME=jenkins \
  JENKINS_PASSWORD=jenkins \
  JENKINS_EXECUTORS=1 \
  JENKINS_LABELS=docker \
  JENKINS_NAME=example-slave

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
  ca-certificates \
  curl \
  debootstrap \
  git \
  openjdk-7-jre-headless \
  openssh-client \
  sudo \
  wget \
  && wget https://packagecloud.io/Hypriot/Schatzkiste/packages/debian/wheezy/docker-hypriot_1.10.3-1_armhf.deb -O /tmp/docker.deb \
  && dpkg -i /tmp/docker.deb \
  && apt-get clean \
  && wget -O /usr/local/bin/swarm-client.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/2.2/swarm-client-2.2-jar-with-dependencies.jar \
  && adduser --shell /bin/sh --disabled-password jenkins

COPY root /

RUN chmod +x /usr/local/bin/run-container.sh

VOLUME ["/home/jenkins"]

CMD ["/usr/local/bin/run-container.sh"]
