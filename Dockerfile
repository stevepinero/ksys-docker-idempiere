#
# iDempiere-KSYS Dockerfile
#
# https://github.com/longnan/ksys-docker-idempiere
#

# Pull base image.
#FROM ubuntu:trusty
FROM phusion/baseimage:0.9.16

MAINTAINER Ken Longnan <ken.longnan@gmail.com>

# Setup proxy
#ENV http_proxy http://10.0.0.12:8087/
#ENV https_proxy http://10.0.0.12:8087/
#RUN export http_proxy=$http_proxy
#RUN export https_proxy=$https_proxy

# Setup fast apt
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse \n" \
		 "deb http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse \n" \
	     "deb http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe multiverse \n" \
		 "deb http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe multiverse \n" \
		 "deb http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe multiverse \n" > /etc/apt/sources.list		 	
		 
RUN apt-get update
RUN apt-get install -q -y openjdk-7-jre-headless openjdk-7-jdk

# Setup JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/
ENV PATH $JAVA_HOME/bin:$PATH
# Minimum memory for the JVM
ENV JAVA_MIN_MEM 256M
# Maximum memory for the JVM
ENV JAVA_MAX_MEM 1024M
# Minimum perm memory for the JVM
ENV JAVA_PERM_MEM 128M
# Maximum memory for the JVM
ENV JAVA_MAX_PERM_MEM 256M

# Install iDempiere-KSYS
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget unzip pwgen expect
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes postgresql-client-9.3

ENV KARAF_VERSION 3.0.3

RUN wget http://archive.apache.org/dist/karaf/${KARAF_VERSION}/apache-karaf-${KARAF_VERSION}.tar.gz -O /tmp/karaf.tar.gz
# Unpack
RUN mkdir /opt/idempiere-ksys;
RUN tar --strip-components=1 -C /opt/idempiere-ksys -xzvf /tmp/karaf.tar.gz
RUN rm /tmp/karaf.tar.gz

#RUN wget http://apache.openmirror.de/karaf/3.0.1/apache-karaf-3.0.1.tar.gz; \
#    mkdir /opt/idempiere-ksys; \
#    tar --strip-components=1 -C /opt/idempiere-ksys -xzvf apache-karaf-3.0.1.tar.gz; \
#    rm apache-karaf-3.0.1.tar.gz; 

# Update karaf etc configuration & setenv
ADD etc/custom.properties /opt/idempiere-ksys/etc/custom.properties
ADD etc/org.ops4j.pax.url.mvn.cfg /opt/idempiere-ksys/etc/org.ops4j.pax.url.mvn.cfg
ADD etc/org.apache.karaf.features.cfg /opt/idempiere-ksys/etc/org.apache.karaf.features.cfg
ADD ksys/setenv /opt/idempiere-ksys/bin/setenv
RUN chmod 755 /opt/idempiere-ksys/bin/setenv;

# Add ksys folder
ADD ksys /opt/idempiere-ksys/ksys

# Add eclipse additional jar to bundles
RUN mv /opt/idempiere-ksys/ksys/org.eclipse.ant.core_3.2.500.v20140203-1328.jar /opt/idempiere-ksys/ksys/bundles; \
	mv /opt/idempiere-ksys/ksys/org.eclipse.core.variables_3.2.700.v20130402-1741.jar /opt/idempiere-ksys/ksys/bundles;

# Add karaf rebranding jar
RUN mv /opt/idempiere-ksys/ksys/com.kylinsystems.idempiere.karaf.branding-2.1.0.jar /opt/idempiere-ksys/lib/;

# Add idempiere-ksys properties file
RUN mv /opt/idempiere-ksys/ksys/myEnvironment.sh /opt/idempiere-ksys/ksys/utils; \
	mv /opt/idempiere-ksys/ksys/idempiere.properties /opt/idempiere-ksys/;

# set +x for utils
RUN chmod 755 /opt/idempiere-ksys/ksys/*.sh;
RUN chmod 755 /opt/idempiere-ksys/ksys/utils/*.sh;
RUN chmod 755 /opt/idempiere-ksys/ksys/utils/postgresql/*.sh;

EXPOSE 1099 8181 8101 44444

# Start iDempiere-KSYS Karaf
ENTRYPOINT ["/opt/idempiere-ksys/bin/karaf"]