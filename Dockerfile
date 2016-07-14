FROM frolvlad/alpine-glibc:alpine-3.4
MAINTAINER He Bai <bai.he@outlook.com>

ENV NOTEBOOK_DIR /notebook

# add python requirements
ADD requirements.txt /requirements.txt

ENV NUMPY_VERSION 1.11.0
ENV PANDAS_VERSION 0.18.1

RUN apk add --no-cache python3-dev && \
    apk add --no-cache --virtual .build-deps g++ && \
    ln -s /usr/include/locale.h /usr/include/xlocale.h && \
    pip3 install numpy==$NUMPY_VERSION && \
    pip3 install pandas==$PANDAS_VERSION && \
    apk del .build-deps

# Install python related packages
RUN apk add --no-cache --virtual .build-deps gcc g++ postgresql-dev curl && \
    pip3 install -r /requirements.txt && \
    pip3 install jupyter && \
    curl -Ls https://www.archlinux.org/packages/core/x86_64/gcc-libs/download > /tmp/gcc-libs.tar.gz && \
    mkdir /usr/libgcc && tar -xvf /tmp/gcc-libs.tar.gz -C /usr/libgcc && \
    apk del .build-deps

RUN echo /usr/libgcc/usr/lib >> /etc/ld.so.conf && \
    /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib && \
    /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 && \
    /usr/glibc-compat/bin/localedef -i zh_CN -f UTF-8 zh_CN.UTF-8 && \
    rm -rf /tmp/glibc*apk /var/cache/apk/*

# Install the jupyter notebook
RUN mkdir -p ${NOTEBOOK_DIR} && echo "c.NotebookApp.open_browser = False" > ${NOTEBOOK_DIR}/jupyter_notebook_config.py

CMD cd ${NOTEBOOK_DIR} && jupyter notebook

