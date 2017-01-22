FROM debian:jessie

ENV TINI_VERSION=v0.13.2 \
  JENKINS_MASTER=https://example.org \
  JENKINS_USERNAME=jenkins \
  JENKINS_PASSWORD=jenkins \
  JENKINS_EXECUTORS=1

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/local/bin/tini
RUN chmod +x /usr/local/bin/tini
ENTRYPOINT ["/usr/local/bin/tini", "--"]

RUN touch /etc/apt/sources.list.d/debian-backports.list \
  && echo "deb http://ftp.ch.debian.org/debian jessie-backports main" | tee /etc/apt/sources.list.d/debian-backports.list

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
  ca-certificates \
  openjdk-8-jre-headless \
  wget \
  && apt-get clean

RUN wget -O /usr/local/bin/swarm-client.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/2.2/swarm-client-2.2-jar-with-dependencies.jar

RUN adduser --shell /bin/sh --disabled-password jenkins

COPY root /
RUN chmod +x /usr/local/bin/run-container.sh

VOLUME ["/home/jenkins"]

CMD ["/usr/local/bin/run-container.sh"]
