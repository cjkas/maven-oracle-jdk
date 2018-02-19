FROM debian:stretch
ENV DEBIAN_FRONTEND noninteractive

# Install tools
RUN apt-get update
RUN apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN apt-get install -y wget git procps

# Install and configure JDK
RUN wget -q --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz
RUN mkdir /usr/java && cd /usr/java && tar x -C /usr/java -f /jdk-8u161-linux-x64.tar.gz && rm /jdk-8u161-linux-x64.tar.gz
RUN update-alternatives --install /usr/bin/java java /usr/java/jdk1.8.0_161/bin/java 100
RUN update-alternatives --install /usr/bin/javac javac /usr/java/jdk1.8.0_161/bin/javac 100

ENV JAVA_HOME /usr/java/jdk1.8.0_161
ENV PATH ${JAVA_HOME}/bin:${PATH}

# Install and configure Maven
RUN cd /opt && wget -q http://www-eu.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz && tar xzf apache-maven-3.5.2-bin.tar.gz && rm apache-maven-3.5.2-bin.tar.gz
RUN ln -s /opt/apache-maven-3.5.2 /opt/maven
ENV M2_HOME /opt/maven
ENV PATH ${M2_HOME}/bin:${PATH}

RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"
RUN apt-get update
RUN apt-get install -y docker-ce

# Test 
RUN mvn --version
RUN java -version

RUN mkdir /.docker && chmod 777 /.docker
RUN rm -fr /var/lib/apt/lists/*

# Create working directory
RUN mkdir -p /local/git
WORKDIR /local/git
CMD [ "/bin/bash", "-l"]