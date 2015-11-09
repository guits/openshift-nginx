FROM openshift/base-centos7

MAINTAINER Guillaume Abrioux "guillaume@abrioux.info"

RUN yum install -y nginx

LABEL io.k8s.description="Nginx Container for proxypass to uwsgi app" \
      io.k8s.display-name="Nginx" \
      io.openshift.expose-services="5000:http" \
      io.openshift.tags="builder,nginx"
# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log
COPY ./configs/nginx.conf.template /opt/templates/nginx.conf.template
COPY ./configs/vhost.conf.template /opt/templates/vhost.conf.template
COPY ./scripts/entrypoint /entrypoint
RUN yum clean all -y

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443 5000
ENTRYPOINT "/entrypoint"
