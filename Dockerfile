FROM armhero/debian:jessie

ENV TINI_VERSION=v0.13.2 \
  JENKINS_MASTER=https://example.org \
  JENKINS_USERNAME=jenkins \
  JENKINS_PASSWORD=jenkins \
  JENKINS_EXECUTORS=1

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-armhf /usr/local/bin/tini

RUN chmod +x /usr/local/bin/tini \
  && touch /etc/apt/sources.list.d/debian-backports.list \
  && echo "deb http://ftp.ch.debian.org/debian jessie-backports main" | tee /etc/apt/sources.list.d/debian-backports.list \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
  ca-certificates \
  curl \
  debootstrap \
  git \
  openjdk-8-jre-headless \
  openssh-client \
  sudo \
  wget \
  && curl -sSL https://get.docker.com/ | sh \
  && apt-get clean \
  && wget -O /usr/local/bin/swarm-client.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/2.2/swarm-client-2.2-jar-with-dependencies.jar \
  && adduser --shell /bin/sh --disabled-password jenkins \
  && adduser jenkins docker \
  && chmod +x /usr/local/bin/run-container.sh

COPY root /

ENTRYPOINT ["/usr/local/bin/tini", "--"]

VOLUME ["/home/jenkins"]

CMD ["/usr/local/bin/run-container.sh"]
