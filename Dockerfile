FROM alpine:3.6

RUN apk add --no-cache git wget ttf-dejavu

# Install JDK GIT MAVEN
RUN wget -O /root/jdk-8u151-linux-x64.tar.gz -q --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz
RUN mkdir /usr/java && cd /usr/java && tar x -C /usr/java -f /root/jdk-8u151-linux-x64.tar.gz && rm /root/jdk-8u151-linux-x64.tar.gz
ENV JAVA_HOME /usr/java/jdk1.8.0_151
ENV PATH ${JAVA_HOME}/bin:${PATH}

RUN mkdir /opt && cd /opt && wget -q http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz && tar xzf apache-maven-3.3.9-bin.tar.gz && rm apache-maven-3.3.9-bin.tar.gz
RUN ln -s /opt/apache-maven-3.3.9 /opt/maven
ENV PATH /opt/maven/bin:${PATH}

# create working directory
RUN mkdir -p /local/git
WORKDIR /local/git
CMD [ "/bin/bash", "-l"]