FROM amancevice/pandas:0.18.1
MAINTAINER He Bai <bai.he@outlook.com>

ENV NOTEBOOK_DIR /notebook

# add python requirements
ADD requirements.txt /requirements.txt

# Install python related packages
RUN set -ex \
    && apk add --no-cache python-dev py-pip \
    && apk add --no-cache --virtual .build-deps gcc g++ postgresql-dev \
    && pip install -r /requirements.txt \
    && pip install jupyter \
    && apk del .build-deps

# Install the jupyter notebook
RUN mkdir -p ${NOTEBOOK_DIR} && echo "c.NotebookApp.open_browser = False" > ${NOTEBOOK_DIR}/jupyter_notebook_config.py

CMD cd ${NOTEBOOK_DIR} && jupyter notebook
