# Install ProbAnch

This project shows how to install ProbAnch on Ubuntu 18.04.

ProbAnch has 19 packages shown below:

``` text
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

Follow the below instructions to install dependencies one-by-one.

## Install ros and libfreenect2

Follow [installAnchoring.md](./installAnchoring.md).

Now that ros has been installed, we can put ProbAnch under a catkin workspace:

``` sh
mkdir -P ~/catkin_ws/src
cd ~/catkin_ws/src
git clone https://github.com/probabilistic-anchoring/probanch.git
git submodule update --recursive --init
```

Run `catkin_make` and it will try to build all packages and fail.

Run `catkin_make --only-pkg-with-deps <package_name>` and it will only build package `package_name`. Use this command to process package one-by-one if the project has too many dependencies.

## Install databse

Follow [database.md](./database.md).

## Install object classification

Follow [object_classification.md](./object_classification.md)

## Install reasoning

Follow [reasoning.md](./reasoning.md)

## Final Build

```
cd ~/catkin_ws
catkin_make
```
