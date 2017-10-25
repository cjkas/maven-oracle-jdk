FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive

# Install tools
RUN apt-get update && apt-get install -y gnupg

# Install JDK GIT MAVEN
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections
RUN apt-get update
RUN apt-get install -y oracle-java8-installer git maven

# create working directory
RUN mkdir -p /local/git
WORKDIR /local/git
CMD ["/bin/bash"]