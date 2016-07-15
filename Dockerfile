FROM frolvlad/alpine-glibc:alpine-3.4
MAINTAINER He Bai <bai.he@outlook.com>

ENV NOTEBOOK_DIR /notebook

# add python requirements
ADD requirements.txt /requirements.txt

ENV NUMPY_VERSION 1.11.0
ENV PANDAS_VERSION 0.18.1

RUN apk add --no-cache python3-dev && \
    apk add --no-cache libstdc++ && \
    apk add --no-cache --virtual .build-deps g++ && \
    ln -s /usr/include/locale.h /usr/include/xlocale.h && \
    pip3 install numpy==$NUMPY_VERSION && \
    pip3 install pandas==$PANDAS_VERSION && \
    apk del .build-deps

# Install python related packages
RUN apk add --no-cache --virtual .build-deps gcc g++ postgresql-dev curl && \
    pip3 --no-cache-dir install -r /requirements.txt && \
    pip3 --no-cache-dir install jupyter && \
    apk del .build-deps && \
    rm -rf /tmp/glibc*apk /var/cache/apk/* /root/.cache/pip

# Install the jupyter notebook
RUN mkdir -p ${NOTEBOOK_DIR} && echo "c.NotebookApp.open_browser = False" > ${NOTEBOOK_DIR}/jupyter_notebook_config.py

EXPOSE 8888

WORKDIR ${NOTEBOOK_DIR}

CMD ["sh", "-c", "jupyter notebook --ip=*"]

