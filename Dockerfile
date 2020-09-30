FROM ubuntu:20.04
 
LABEL maintainer="programming@bymatej.com"

# Update
RUN sudo apt --assume-yes update
# Install required software and tools
RUN sudo apt --assume-yes install openjdk-8-jre-headless wget unzip

# Download McMyAdmin
RUN wget http://mcmyadmin.com/Downloads/etc.zip -P /usr/local
RUN unzip /usr/local/etc.zip && rm /usr/local/etc.zip
RUN mkdir /McMyAdmin
WORKDIR /McMyAdmin
RUN wget http://mcmyadmin.com/Downloads/MCMA2_glibc26_2.zip
RUN unzip MCMA2_glibc26_2.zip
RUN rm MCMA2_glibc26_2.zip
./MCMA2_Linux_x86_64 -setpass [YOURPASSWORD] -configonly
