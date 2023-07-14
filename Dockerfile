FROM nvidia/cuda:11.8.0-base-ubuntu18.04

# RUN pip install -i https://mirrors.aliyun.com/pypi/simple pipenv
RUN mkdir /root/work
USER root
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt update -y



RUN conda config --set auto_activate_base false



RUN apt install -y net-tools
RUN apt install -y vim && apt install -y htop

ENV TIME_ZONE=Asia/Shanghai
RUN echo "${TIME_ZONE}" > /etc/timezone && ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime
RUN find . -name "*.pyc" -delete

CMD ["jupyter", "lab", "--allow-root"]



