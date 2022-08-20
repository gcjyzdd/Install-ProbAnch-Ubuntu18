# Install IAI Kinect2 on Ubuntu 18.04

## Install ROS

``` sh
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt install curl # if you haven't already installed curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update
sudo apt install ros-melodic-desktop-full
```

Setup ROS environment for bash:

``` sh
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc
```

or for zsh:

``` sh
echo "source /opt/ros/melodic/setup.zsh" >> ~/.zshrc
source ~/.zshrc
```

Install tools for ROS:

``` sh
sudo apt install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
```

Init `rosdep`:

``` sh
sudo rosdep init
rosdep update
```

## Install libfreenect2

Download CUDA samples under the same directory as libfreenect2:
``` sh
git clone https://github.com/NVIDIA/cuda-samples.git
```

``` sh
sudo apt-get update && sudo apt-get install -y libusb-1.0-0-dev libglfw3-dev libturbojpeg0-dev
git clone --recursive https://github.com/gcjyzdd/libfreenect2.git && \
  cd libfreenect2 && mkdir build && cd build && \
  cmake .. -DENABLE_CXX11=ON -DENABLE_CUDA=ON -DNVCUDASAMPLES_ROOT=`pwd`/../../cuda-samples && make -j4 && sudo make install && \
  cd ../.. && rm -rf libfreenect2
```

### Setup permission of kinect2

Set up udev rules for device access:
``` sh
sudo cp platform/linux/udev/90-kinect2.rules /etc/udev/rules.d/
```
then replug the Kinect.

# Install OpenCV 3.4
``` sh
sudo apt-get update && sudo apt-get install -y libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev
git clone https://github.com/opencv/opencv.git && git clone https://github.com/opencv/opencv_contrib.git && \
  cd opencv_contrib && git checkout 3.4.7 && cd ../opencv && git checkout 3.4.7 && \
  mkdir build && cd build && \
  cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules/ .. -DENABLE_PRECOMPILED_HEADERS=OFF && \
  make -j4 && sudo make install && \
  cd ../.. && rm -rf opencv_contrib opencv
```

Ref:
* `-DENABLE_PRECOMPILED_HEADERS=OFF`: https://github.com/opencv/opencv/issues/14868

## Install

Use:
``` sh
# https://answers.ros.org/question/118151/install-ros-on-linux-mint-16/
export ROS_OS_OVERRIDE=ubuntu:18.04:bionic
```
if you use Linux Mint or other linux distributions than Ubuntu.

``` sh
mkdir -p ~/catkin_ws/src/
cd ~/catkin_ws/src/
rosdep install -r --from-paths .
```

``` text
Note: rosdep will output errors on not being able to locate [kinect2_bridge] and [depth_registration]. That is fine because they are all part of the iai_kinect2 package and rosdep does not know these packages.

Note: If you installed libfreenect2 somewhere else than in $HOME/freenect2 or a standard location like /usr/local you have to specify the path to it by adding -Dfreenect2_DIR=path_to_freenect2/lib/cmake/freenect2 to catkin_make.
```

### Use CUDA and OpenCL(optional):

``` sh
sudo apt-get install nvidia-modprobe opencl-headers
```

You also need to add CUDA paths to the system environment, add these lines to you `~/.bashrc`:

``` sh
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:${LD_LIBRARY_PATH}"
export PATH="/usr/local/cuda/bin:${PATH}"
```

### Build

``` sh
cd ~/catkin_ws
catkin_make -DCMAKE_BUILD_TYPE="Release"
```

## Run

Setup shell environment:

``` sh
# for bash
source ~/catkin_ws/devel/setup.bash
# for zsh
source ~/catkin_ws/devel/setup.zsh
```

Start `kinect2_bridge`:
``` sh
cd /home/changjie/catkin_ws/src/iai_kinect2/kinect2_bridge/launch
roslaunch kinect2_bridge kinect2_bridge.launch
```

Run `kinect2_viewer` in another terminal:
``` sh
rosrun kinect2_viewer kinect2_viewer kinect2 sd cloud
```
