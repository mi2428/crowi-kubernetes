FROM elasticsearch:5
MAINTAINER MIYA Taichi <miya@d.u.m.m.y.titech.ac.jp>

ENV xpack.security.enabled=false \
    ES_JAVA_OPTS="-Xms512m -Xmx512m"

RUN elasticsearch-plugin install analysis-kuromoji
