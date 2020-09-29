FROM ubuntu:20.04
 
LABEL maintainer="programming@bymatej.com"

# Update
RUN sudo apt --assume-yes update
# Install required software and tools
RUN sudo apt --assume-yes install openjdk-8-jre-headless wget unzip

# Download McMyAdmin
RUN wget http://mcmyadmin.com/Downloads/etc.zip -P /usr/local
RUN unzip /usr/local/etc.zip && rm /usr/local/etc.zip
https://mcmyadmin.com/#/download
