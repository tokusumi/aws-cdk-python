ARG CDK_VERSION=1.100

FROM node:14
LABEL maintainer="Tomoro Tokusumi"

RUN apt-get update \
    && apt-get install nano less \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN cd /opt \
    && curl -q "https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tgz" -o Python-3.7.6.tgz \
    && tar -xzf Python-3.7.6.tgz \
    && cd Python-3.7.6 \
    && ./configure --enable-optimizations \
    && make install

RUN cd /opt \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

RUN npm install -g aws-cdk@$CDK_VERSION \
    && npm cache clean --force

RUN rm -rf /opt/*

RUN echo "alias ls='ls --color=auto'" >> /root/.bashrc \
    && echo "PS1='🐳 \[\033[1;36m\]\h:\[\033[1;34m\]\W\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]'" >> /root/.bashrc
ENV TERM=xterm-256color

RUN mkdir -p /root/.ssh

WORKDIR /root

CMD ["/bin/bash"]