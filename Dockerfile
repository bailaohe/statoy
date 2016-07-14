FROM frolvlad/alpine-glibc:alpine-3.4
MAINTAINER He Bai <bai.he@outlook.com>

ENV NOTEBOOK_DIR /notebook

# add python requirements
ADD requirements.txt /requirements.txt


ENV PANDAS_VERSION 0.18.1
RUN apk add --no-cache python3-dev && \
    apk add --no-cache --virtual .build-deps g++ && \
    ln -s /usr/include/locale.h /usr/include/xlocale.h && \
    pip3 install numpy==1.11.0 && \
    pip3 install pandas==$PANDAS_VERSION && \
    apk del .build-deps

# Install python related packages
RUN apk add --no-cache --virtual .build-deps gcc g++ postgresql-dev \
    && pip3 install -r /requirements.txt \
    && pip3 install jupyter \
    && apk del .build-deps

# Install the jupyter notebook
RUN mkdir -p ${NOTEBOOK_DIR} && echo "c.NotebookApp.open_browser = False" > ${NOTEBOOK_DIR}/jupyter_notebook_config.py

# Download required libraries libgcc_s.so.1, libstdc++.so.6
RUN apk add --no-cache curl && \
    curl -Ls https://www.archlinux.org/packages/core/x86_64/gcc-libs/download > /tmp/gcc-libs.tar.gz && \
    mkdir /usr/libgcc && tar -xvf /tmp/gcc-libs.tar.gz -C /usr/libgcc && \
    apk del curl

RUN echo /usr/libgcc/usr/lib >> /etc/ld.so.conf
RUN /usr/glibc-compat/sbin/ldconfig

CMD cd ${NOTEBOOK_DIR} && jupyter notebook

