FROM ubuntu:20.04

LABEL maintainer="programming@bymatej.com"

ARG DEBIAN_FRONTEND=noninteractive
ENV MCMA_PASSWORD=admin

# Update and install required software and tools
RUN apt --assume-yes update
RUN apt --assume-yes install openjdk-8-jre-headless \
                                  wget \
                                  unzip \
                                  expect

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
RUN echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java" >> /etc/profile && \
    echo "PATH=$PATH:$HOME/bin:$JAVA_HOME/bin" >> /etc/profile && \
    echo "export JAVA_HOME" >> /etc/profile && \
    echo "export JRE_HOME" >> /etc/profile && \
    echo "export PATH" >> /etc/profile

# Set iptables
#RUN iptables -A INPUT -p tcp -m tcp --dport 8080 -j ACCEPT && \
#    iptables -A INPUT -p tcp -m tcp --dport 8081 -j ACCEPT && \
#    iptables -A INPUT -p tcp -m tcp --dport 25565 -j ACCEPT && \
#    iptables-save

# Download and install Mono for McMyAdmin
WORKDIR /usr/local
RUN wget http://mcmyadmin.com/Downloads/etc.zip
RUN unzip etc.zip && \
    rm etc.zip

# Download McMyAdmin
WORKDIR /McMyAdmin
RUN wget http://mcmyadmin.com/Downloads/MCMA2_glibc26_2.zip
RUN unzip MCMA2_glibc26_2.zip
RUN rm MCMA2_glibc26_2.zip

# Run initial setup for McMyAdmin
ADD configure_mcma.sh .
RUN ./configure_mcma.sh

# Agree to EULA
#RUN sed -i 's/eula=false/eula=true/g' /McMyAdmin/Minecraft/eula.txt
RUN touch /McMyAdmin/Minecraft/eula.txt &&
    "eula=true" >> /McMyAdmin/Minecraft/eula.txt

# Configure McMyAdmin
RUN sed -i 's/eula=false/eula=true/g' /McMyAdmin/Minecraft/eula.txt



#temp
CMD tail -f /dev/null
