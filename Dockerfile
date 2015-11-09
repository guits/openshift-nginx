FROM openshift/base-centos7

MAINTAINER Guillaume Abrioux "guillaume@abrioux.info"

RUN yum install -y nginx

LABEL io.k8s.description="Nginx Container for proxypass to uwsgi app" \
      io.k8s.display-name="Nginx" \
      io.openshift.expose-services="5000:http" \
      io.openshift.tags="builder,nginx"

COPY ./configs/nginx.conf.template /opt/templates/nginx.conf.template
COPY ./configs/vhost.conf.template /opt/templates/vhost.conf.template
COPY ./scripts/entrypoint /entrypoint
RUN yum clean all -y

#RUN ln -sf /dev/stdout /var/log/nginx/access.log
#RUN ln -sf /dev/stderr /var/log/nginx/error.log

RUN chmod -R 777 /var/log/nginx /var/lib/nginx /etc/nginx /var/run

EXPOSE 5000
ENTRYPOINT "/entrypoint"
