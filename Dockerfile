# tinyMediaManager 
FROM hurricane/dockergui:x11rdp1.3
MAINTAINER Carlos Hernandez <carlos@techbyte.ca>

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################
# Set correct environment variables
ENV LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8" 
ENV APP_NAME tinyMediaManager
ENV TMMVER tmm_2.9.6_94c1e5f_linux

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

#########################################
##         EXPORTS AND VOLUMES         ##
#########################################
VOLUME ["/config"]
EXPOSE 3389 8080

#########################################
##         RUN INSTALL SCRIPT          ##
#########################################
COPY ./files/ /tmp/

#########################################
##         INSTALL LIBMEDIAINFO        ##
#########################################
RUN apt-get update \
&& apt-get install -y libmediainfo0 \

#########################################
## INSTALL DIRECTLY FROM RELEASE PAGE  ##
#########################################
&& mkdir /tinyMediaManager \
&& wget http://release.tinymediamanager.org/dist/$TMMVER.tar.gz -O /tmp/tinyMediaManager.tar.gz \
&& tar -zxvf /tmp/tinyMediaManager.tar.gz -C /tinyMediaManager \
&& chmod -R ugo+rw /tinyMediaManager \
&& chmod +x /tmp/install/tmm_install.sh && /tmp/install/tmm_install.sh && rm -r /tmp/install

