FROM python:3.5.1-alpine
MAINTAINER He Bai <bai.he@outlook.com>

ENV NOTEBOOK_DIR /notebook

# add python requirements
ADD requirements.txt /root/requirements.txt

# Install python related packages
RUN set -ex \
    && apk add --no-cache --virtual .build-deps  \
        g++ \
        postgresql-dev \
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && pip3 install -r /root/requirements.txt \
    && pip3 install jupyter \
    && find /usr/local -depth \
        \( \
            \( -type d -a -name test -o -name tests \) \
            -o \
            \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        \) -exec rm -rf '{}' + \
    && runDeps="$( \
        scanelf --needed --nobanner --recursive /usr/local \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | sort -u \
            | xargs -r apk info --installed \
            | sort -u \
    )" \
    && apk add --virtual .python-rundeps $runDeps \
    && apk del .build-deps \
    && rm -rf /usr/src/python ~/.cache

# Install the jupyter notebook
RUN mkdir -p ${NOTEBOOK_DIR} && echo "c.NotebookApp.open_browser = False" > ${NOTEBOOK_DIR}/jupyter_notebook_config.py

CMD cd ${NOTEBOOK_DIR} && jupyter notebook
