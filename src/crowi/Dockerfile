FROM node:6
MAINTAINER MIYA Taichi <miya@d.u.m.m.y.titech.ac.jp>

ENV VERSION=v1.6.2 \
    NODE_ENV=production

WORKDIR /opt/crowi
RUN curl -SL https://github.com/crowi/crowi/archive/${VERSION}.tar.gz |\
    tar xz -C /opt/crowi --strip-components=1 &&\
    npm install --unsafe-perm

COPY init.sh /sbin/init.sh
RUN chmod 700 /sbin/init.sh

EXPOSE 3000/tcp
VOLUME ["/opt/crowi/public/uploads"]

ENTRYPOINT ["/sbin/init.sh"]
CMD ["npm", "start"]
