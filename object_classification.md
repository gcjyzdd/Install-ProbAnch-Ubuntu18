# Install object_classification

``` sh
#sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
#sudo apt-get install --no-install-recommends libboost-all-dev
sudo apt-get install libleveldb-dev libsnappy-dev 
sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev
```

## OpenBLAS support (default is ATLAS used):
``` sh
sudo apt-get install libopenblas-base libopenblas-dev
```

## Install cuDNN

``` sh
sudo dpkg -i cudnn-local-repo-ubuntu1804-8.5.0.96_1.0-1_amd64.deb
# if the above command gets you an error, try below and rerun the command above
sudo cp /var/cudnn-local-repo-ubuntu1804-8.5.0.96/cudnn-local-7B49EDBC-keyring.gpg /usr/share/keyrings/cuda-archive-keyring.gpg
```

## Update CMake to support CUDA

``` sh
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'
sudo apt update
sudo apt install -y cmake
```

## Build caffe

``` sh
cd ~/Documents
git clone https://github.com/BVLC/caffe.git --branch 1.0 --depth 1
mkdir build && cd build
cmake .. -DBLAS=Open
```

```
traversing 14 packages in topological order:
- console
- anchor_msgs
- database
- hand_tracking
- ml
- features
- object_classification
- reasoning
- feature_extraction
- anchoring
- ar_transform
- object_tracking
- display
- object_segmentation
```

## Build object_classification

Set environment variable `CAFFE_ROOT` to build `caffe`:

``` sh
export CAFFE_ROOT=/home/changjie/Documents/caffe
```

``` sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/changjie/Documents/caffe/build/install/lib:/usr/lib/x86_64-linux-gnu/hdf5/serial
```

### Fix CMakeLists.txt

Change 
``` cmake
set(Caffe_LINK_LIBRARAY ${Caffe_DIR}/build/lib)
``` 
to
``` cmake
set(Caffe_LINK_LIBRARAY ${Caffe_DIR}/lib)
````

### Build

Build `object_classification`:
``` sh
catkin_make --only-pkg-with-deps object_classification
```
