FROM frolvlad/alpine-glibc:alpine-3.4
MAINTAINER He Bai <bai.he@outlook.com>

# add python requirements
ADD requirements.txt /requirements.txt

# Install python related packages
RUN apk add --no-cache python3-dev && \
    apk add --no-cache libstdc++ && \
    apk add --no-cache --virtual .build-deps g++ && \
    ln -s /usr/include/locale.h /usr/include/xlocale.h && \
    apk add --no-cache postgresql-dev && \
    apk add --no-cache mariadb-dev && \
    pip3 --no-cache-dir install -r /requirements.txt && \
    pip3 --no-cache-dir install jupyter && \
    apk del .build-deps && \
    rm -rf /tmp/glibc*apk /var/cache/apk/* /root/.cache/pip && \
    mkdir /notebooks

# Install the jupyter notebook
VOLUME /notebooks
EXPOSE 8888

CMD ["sh", "-c", "jupyter notebook --no-browser --ip=* --notebook-dir=/notebooks"]

