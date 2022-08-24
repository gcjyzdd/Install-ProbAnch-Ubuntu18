# Install reasoning

## Prerequisites to install YAP Prolog

Make sure the readline library is installed properly:

``` sh
sudo apt-get install -y libreadline-dev
sudo apt-get install -y libncurses5-dev
```

For Ubuntu 18.04 you first need to add xenial to your sources.list:

``` sh
echo "deb http://dk.archive.ubuntu.com/ubuntu/ xenial main" | sudo tee -a /etc/apt/sources.list
echo "deb http://dk.archive.ubuntu.com/ubuntu/ xenial universe" | sudo tee -a /etc/apt/sources.list
sudo apt update
sudo apt install g++-4.9
sudo apt-get install gcc-4.9
```

Use update-alternatives to temporarily change to them.

``` sh
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 100 --slave /usr/bin/g++ g++ /usr/bin/g++-7
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 50 --slave /usr/bin/g++ g++ /usr/bin/g++-4.9
```

``` sh
sudo update-alternatives --set gcc "/usr/bin/gcc-4.9"
gcc --version
```

## Install YAP

``` sh
cd /tmp
wget https://bitbucket.org/problog/dc_problog/downloads/yap-6.2.2.zip
unzip yap-6.2.2.zip && cd yap-6.2.2 && mkdir arch && cd arch \
     && ../configure --enable-tabling=yes --enable-dynamic-loading --disable-myddas && make -j4 && sudo make install && sudo make install_library
```

Change back `gcc`:
``` sh
sudo update-alternatives --set gcc "/usr/bin/gcc-7"
gcc --version
```

## Prerequisites to compile Distributional Clauses

``` sh
sudo apt-get install -y libgsl-dev libboost-all-dev
```

## Install Distributional Clauses

``` sh
mkdir ~/Documents/packages
cd ~/Documents/packages
git clone https://bitbucket.org/problog/dc_problog.git
cd dc_problog && sh make.sh
echo "export YAPSHAREDIR=`pwd`/dc_problog" >> ~/.bashrc
# if you use zsh
echo "export YAPSHAREDIR=`pwd`/dc_problog" >> ~/.zshrc
```

### Test dc
Execute
``` sh
sh test.sh
```

## Install PyDC

``` sh
cd ~/Documents/packages
git clone https://github.com/ML-KULeuven/PyDC.git pydc
cd pydc
sudo python setup.py install --force
```

### Test
To make sure that everything is in order try running one of the examples, e.g.:

``` sh
python examples/example_dc/example_dc.py
```

## Build reasoning

``` sh
cd ~/catkin_ws
catkin_make --only-pkg-with-deps reasoning
```

## Install feature_extraction

``` sh
sudo apt-get install -y ros-melodic-tf2-msgs ros-melodic-tf2-sensor-msgs
catkin_make --only-pkg-with-deps feature_extraction
```

``` sh
catkin_make --only-pkg-with-deps anchoring
catkin_make --only-pkg-with-deps ar_transform
catkin_make --only-pkg-with-deps object_tracking
catkin_make --only-pkg-with-deps display
catkin_make --only-pkg-with-deps object_segmentation
```
