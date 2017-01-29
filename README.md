# Jenkins Slave

[![](https://images.microbadger.com/badges/image/armhero/jenkins-slave.svg)](https://microbadger.com/images/armhero/jenkins-slave "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/armhero/jenkins-slave.svg)](https://microbadger.com/images/armhero/jenkins-slave "Get your own version badge on microbadger.com")

The Jenkins slave used to generate ARMhero images. It uses the swarm plugin to communicate with the master. The image is inherit from [armhero/debian](https://github.com/armhero/debian).

## Integridents

* **Jenkins Swarm Plugin 2.2**
* **Debootstrap**
* **Docker** (For controlling the docker daemon on the host)
* **OpenJDK 8**

## Usage

You need to have the swarm plugin installed. Then you can run the slave like this:
```
docker run -v /var/run/docker.sock:/var/run/docker.sock \
  -e JENKINS_MASTER=https://your-jenkins.example.com \
  -e JENKINS_USERNAME=your_jenkins_user \
  -e JENKINS_PASSWORD=your_jenkins_password
```
