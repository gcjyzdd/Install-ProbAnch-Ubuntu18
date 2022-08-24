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
