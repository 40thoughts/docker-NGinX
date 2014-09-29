# Select the latest ubuntu image to build this container
########################################################
FROM crazybud/base-ubu-latest:latest
MAINTAINER crazyBUD

# add needed packages
#####################
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq nginx

# docker settings
#################

# map /root/config and /root/data to host.
VOLUME /root/data
VOLUME /root/config

# expose port for http : 80
EXPOSE 80

# add conf file
###############

ADD .nginx.conf /etc/supervisor/conf.d/nginx.conf

# Lighten the image if possible
###############################
RUN apt-get clean && rm -rf /tmp/*

# run `supervisor`
##################
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor.conf", "-n"]

#sudo docker run -d --name "nginx" -p 4000:80 -v /home/michael/Projets/docker/NGinX/data:/root/data -v /home/michael/Projets/docker/NGinX/config:/root/config -v /etc/localtime:/etc/localtime:ro b8dde64a703c
