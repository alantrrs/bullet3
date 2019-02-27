FROM nvidia/cudagl:9.2-devel

RUN apt update && apt install -y freeglut3-dev build-essential \
  python3 python3-pip python3-tk libeigen3-dev wget software-properties-common && \
  pip3 install numpy

# install CMake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.13.4/cmake-3.13.4.tar.gz \
  && tar -xzvf cmake-3.13.4.tar.gz && cd cmake-3.13.4 \
  && ./bootstrap && make -j4 && make install

# install Clang
RUN wget -qO - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
  && add-apt-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-6.0 main" \
  && apt update && apt install -y clang-6.0 \
  && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-6.0 1000 \
  && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-6.0 1000

COPY . /bullet3
WORKDIR /bullet3

# install pybullet
RUN python3 setup.py install
