FROM airdock/oracle-jdk:jdk-1.8

RUN apt-get update && apt-get install -y wget git

RUN cd /opt && wget -q http://www-eu.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz && tar xzf apache-maven-3.5.2-bin.tar.gz && rm apache-maven-3.5.2-bin.tar.gz
RUN ln -s /opt/apache-maven-3.3.9 /opt/maven
ENV PATH /opt/maven/bin:${PATH}

# create working directory
RUN mkdir -p /local/git
WORKDIR /local/git
