from nvidia/cuda:11.7.1-cudnn8-devel-ubuntu18.04

RUN apt update && apt install -y git build-essential \
      pkg-config libusb-1.0-0-dev libglfw3-dev mesa-utils \
      libturbojpeg0-dev pkg-config python3 python3-pip \
      && pip3 install cmake==3.22

RUN git clone https://github.com/NVIDIA/cuda-samples.git \
  && git clone --recursive https://github.com/gcjyzdd/libfreenect2.git

RUN export PATH=$PATH:/usr/local/bin \
  && cd libfreenect2 && mkdir build && cd build && \
  cmake .. -DENABLE_CXX11=ON -DENABLE_CUDA=ON \
  -DNVCUDASAMPLES_ROOT=`pwd`/../../cuda-samples && make -j4

# Install vnc
# https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
ENV DEBIAN_FRONTEND=noninteractive
# https://www.howtogeek.com/devops/how-to-run-gui-applications-in-a-docker-container/
RUN apt-get update && apt-get install -y firefox x11vnc xvfb
#RUN echo "exec firefox" > ~/.xinitrc && chmod +x ~/.xinitrc
#RUN echo "exec bash" > ~/.xinitrc && chmod +x ~/.xinitrc

ENV LIBGL_ALWAYS_INDIRECT=1
RUN apt-get install -y libgl1-mesa-glx dbus

#RUN mkdir ~/.vnc && \
#  x11vnc -storepasswd 1234 ~/.vnc/passwd
#COPY entrypoint.sh /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]

# Install real-VNC viewer on host
# https://www.realvnc.com/en/connect/download/viewer/

# docker build -t freekinect2 .
# docker run -it --rm --gpus all freekinect2

# lsusb 
# dmesg
# docker run -it --rm --gpus all --privileged -v /dev:/dev -p5900:5900 freekinect2
# /libfreenect2/build/bin/Protonect

# connect to the container using 0.0.0.0:5900

# https://computingforgeeks.com/run-ubuntu-linux-in-docker-with-desktop-environment-and-vnc/

## method 2
# xhost +
# docker run -it --gpus all --privileged -v /dev:/dev -p5900:5900 \
#   -e DISPLAY=$DISPLAY --net host \
#   -v /tmp/.X11-unix:/tmp/.X11-unix:rw freekinect2 /libfreenect2/build/bin/Protonect
# test of firefox works but kinect2
