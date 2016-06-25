FROM python:3.5.1-alpine
MAINTAINER He Bai <bai.he@outlook.com>

ENV NOTEBOOK_DIR /root/notebook

# add python requirements
ADD requirements.txt /root/requirements.txt

# Install python related packages
RUN set -ex \
    && apk add --no-cache --virtual .build-deps gcc g++ postgresql-dev \
    && pip install -r /root/requirements.txt \
    && pip install jupyter \
    && apk del .build-deps \

# Install the jupyter notebook
RUN mkdir -p ${NOTEBOOK_DIR} && echo "c.NotebookApp.open_browser = False" > ${NOTEBOOK_DIR}/jupyter_notebook_config.py

CMD cd ${NOTEBOOK_DIR} && jupyter notebook
