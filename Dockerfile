FROM jenkins/jenkins:lts

USER root

# Install Java
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk wget git bash docker.io && \
    apt-get clean

# Install Maven 3.9.8
RUN MAVEN_VERSION=3.9.8 && \
    MAVEN_URL=https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    wget -O /tmp/apache-maven-${MAVEN_VERSION}-bin.tar.gz ${MAVEN_URL} && \
    tar -xz -C /opt -f /tmp/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven && \
    ln -s /opt/maven/bin/mvn /usr/bin/mvn && \
    rm /tmp/apache-maven-${MAVEN_VERSION}-bin.tar.gz

# Add Jenkins user to the Docker group
RUN usermod -aG docker jenkins

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64 \
    MAVEN_HOME=/opt/maven \
    PATH=$PATH:/usr/lib/jvm/java-17-openjdk-amd64/bin:/opt/maven/bin

USER jenkins

# sudo systemctl start docker
# sudo systemctl enable docker


# docker build -t my-jenkins:latest .
# docker run -d --name jenkins -p 8090:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home my-jenkins:latest

# docker network create jenkins
# docker run -d --name jenkins --network jenkins --group-add docker -v jenkins_home:/var/jenkins_home -v //var/run/docker.sock:/var/run/docker.sock -e DOCKER_HOST=tcp://host.docker.internal:2375 -p 8090:8080 -p 50000:50000 my-jenkins:latest

# docker exec -u root -it jenkins bash

# usermod -aG docker jenkins
# exit

# docker restart jenkins
