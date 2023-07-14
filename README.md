# DockerJupyterLab-nvidia
JupyterLab的Docker镜像构建及容器部署(支持在容器里面使用英伟达GPU)

## 配置信息
本仓库实验的机器系统及显卡配置信息如下:
Ubuntu 18.04.6 LTS, x86_64, NVIDIA Tesla V100 SXM2 16GB with CUDA 11.8

## 准备工作
1. 首先确保主机上的NVIDIA驱动程序正常工作, 要能够成功运行`nvidia-smi`并看到GPU名称、驱动程序版本和CUDA版本等;
2. 将NVIDIA Container Toolkit添加到主机, 它会集成到Docker引擎中以自动配置容器以支持GPU, 使用示例命令将工具包的包存储库添加到主机系统: 
```sh
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
```
3. 接下来在主机上安装nvidia-docker2软件包:
```sh
apt-get update
apt-get install -y nvidia-docker2
```
4. 重启Docker守护进程以完成安装:
```sh
systemctl restart docker
```

5. 在容器里面查看宿主机GPU信息:
```sh
docker run -it --gpus all nvidia/cuda:11.8.0-base-ubuntu18.04 nvidia-smi
```
如果没问题则会显示与在主机使用`nvidia-smi`查看GPU信息时一模一样的信息.

## JupyterLab镜像构建及容器部署
基于`./Dockfile`构建JupyterLab镜像:
```sh
# Building JupyterLab Docker Image Based on `./Dockerfile`.
docker build --no-cache -t IMAGE_NAME .

# Container Deployment
docker run -u root -d -p SERVER_PORT:8888 -v SERVER_DIR_ABSPATH:/root/work --name="CONTAINER_NAME" --gpus all IMAGE_NAME
```

## 页面访问
JupyterLab容器部署好以后, 可通过此链接来访问JupyterLab: `http://SERVER_IP:SERVER_PORT/lab/tree/root/work`, 如果无法访问, 可能是没有`SERVER_PORT`的权限.

首次浏览器登入JupyterLab需要输入密码或Token, Token可以在启动日志里面找到, 查看启动日志的命令如下: 
```sh
docker logs CONTAINER_NAME
```








