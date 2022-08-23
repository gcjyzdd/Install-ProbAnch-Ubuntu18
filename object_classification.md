# Install object_classification

``` sh
sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
#sudo apt-get install --no-install-recommends libboost-all-dev
sudo apt-get install libleveldb-dev libsnappy-dev 
sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev
```

## OpenBLAS support (default is ATLAS used):
``` sh
sudo apt-get install libopenblas-base libopenblas-dev
```
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

catkin_make --only-pkg-with-deps object_classification
