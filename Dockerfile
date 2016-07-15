FROM frolvlad/alpine-glibc
MAINTAINER He Bai <bai.he@outlook.com>

ENV PATH=/opt/conda/bin:$PATH \
    LANG=C.UTF-8 \
    MINICONDA=Miniconda3-latest-Linux-x86_64.sh

RUN apk add --no-cache --virtual=build-dependencies bash wget && \
    wget -q --no-check-certificate https://repo.continuum.io/miniconda/$MINICONDA && \
    bash /$MINICONDA -b -p /opt/conda && \
    conda update -y conda pip setuptools && \
    apk del build-dependencies

RUN find /opt -name __pycache__ | xargs rm -r && \
    rm -rf /root/.[apw]* /$MINICONDA /opt/conda/pkgs/*

CMD ["sh"]
