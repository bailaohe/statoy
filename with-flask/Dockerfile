from bailaohe/statoy:base2

ADD requirements.txt /requirements.txt

# Install python related packages
RUN pip3 --no-cache-dir install -r /requirements.txt && \
    rm -rf /root/.cache/pip 


