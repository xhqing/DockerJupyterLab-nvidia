FROM nvidia/cuda:11.8.0-base-ubuntu18.04

RUN mkdir /root/work
USER root
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt update -y

RUN apt install -y net-tools && apt install -y wget && apt install -y git
RUN apt install -y vim && apt install -y htop && apt install -y openssh-client

ENV TIME_ZONE=Asia/Shanghai
RUN echo "${TIME_ZONE}" > /etc/timezone && ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime

# RUN apt-get install build-essential checkinstall libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev && \
#    cd /usr/src && wget https://npm.taobao.org/mirrors/python/3.9.12/Python-3.9.12.tgz && tar xzf Python-3.9.12.tgz && cd Python-3.9.12 && ./configure --enable-optimizations && make altinstall
# RUN pip3.9 install -i https://mirrors.aliyun.com/pypi/simple pipenv

ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && /bin/bash ~/miniconda.sh -b -p /opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH
RUN conda install -c conda-forge jupyterlab

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root"]



