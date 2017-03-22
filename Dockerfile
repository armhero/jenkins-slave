FROM armhero/raspbian:jessie

ENV SWARM_CLIENT_VERSION=3.3 \
  JENKINS_MASTER=https://example.org \
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
  locales \
  openjdk-7-jre-headless \
  openssh-client \
  sudo \
  wget \
  && curl -s https://packagecloud.io/install/repositories/Hypriot/Schatzkiste/script.deb.sh | sudo bash \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y docker-hypriot \
  && apt-get clean \
  && wget -O /usr/local/bin/swarm-client.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${SWARM_CLIENT_VERSION}/swarm-client-${SWARM_CLIENT_VERSION}.jar \
  && adduser --shell /bin/sh --disabled-password jenkins \
  && dpkg-reconfigure locales \
  && locale-gen C.UTF-8 \
  && /usr/sbin/update-locale LANG=C.UTF-8

ENV LC_ALL C.UTF-8

COPY root /

RUN chmod +x /usr/local/bin/run-container.sh

VOLUME ["/home/jenkins"]

CMD ["/usr/local/bin/run-container.sh"]
