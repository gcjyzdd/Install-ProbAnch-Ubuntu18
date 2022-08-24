# Install database

## Install mongoDB

``` sh
sudo apt update  && sudo apt-get install -y gnupg apt-utils
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
sudo apt-get update && sudo apt-get install -y mongodb-org
```

## install mongoDB C drivers
``` sh
sudo apt-get install -y pkg-config libssl-dev libsasl2-dev git gcc automake autoconf libtool cmake build-essential python3
cd /tmp
git clone --branch 1.21.1 https://github.com/mongodb/mongo-c-driver.git && cd mongo-c-driver && mkdir cmake-build && cd cmake-build && \
  cmake -DENABLE_AUTOMATIC_INIT_AND_CLEANUP=OFF .. &&  make -j4 && sudo make install
cd ~/catkin_ws
```

## Install MongoDB C++ drivers
``` sh
cd /tmp
git clone https://github.com/mongodb/mongo-cxx-driver.git --branch r3.3.0 --depth 1 && cd mongo-cxx-driver/build && \
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local .. && sudo make EP_mnmlstc_core -j4 && make -j4 && sudo make install
cd ~/catkin_ws
```

### Check build

``` sh
catkin_make anchor_msgs -DCMAKE_BUILD_TYPE="Release"
```

It should pass `database`.

## Install AR-based tracking

``` sh
sudo apt-get install ros-melodic-ar-track-alvar
```

```
traversing 19 packages in topological order:
- iai_kinect2 (metapackage)
- console
- anchor_msgs
- database
- hand_tracking
- kinect2_registration
- ml
- features
- object_classification
- reasoning
- feature_extraction
- kinect2_bridge
- kinect2_calibration
- kinect2_viewer
- anchoring
- ar_transform
- object_tracking
- display
- object_segmentation
```

``` sh
cd ~/catkin_ws
catkin_make --only-pkg-with-deps console
catkin_make --only-pkg-with-deps anchor_msgs
catkin_make --only-pkg-with-deps database
catkin_make --only-pkg-with-deps hand_tracking
catkin_make --only-pkg-with-deps ml
catkin_make --only-pkg-with-deps features
```
