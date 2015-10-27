FROM d9magai/libuv
MAINTAINER d9magai

ENV H2O_PREFIX /opt/h2o
ENV H2O_SRC_PATH $H2O_PREFIX/src

ENV CMAKE_2_8_12_RPM_URL ftp://rpmfind.net/linux/sourceforge/r/ra/ramonelinux/Rel_0.98/releases/x86_64/packages/cmake-2.8.12-1.ram0.98.x86_64.rpm

RUN yum update -y && yum install -y \
    git \
    gcc-c++ \
    libarchive \
    openssl-devel \
    libyaml-devel \
    && yum clean all
RUN rpm -ivh $CMAKE_2_8_12_RPM_URL

RUN git clone --recursive https://github.com/h2o/h2o $H2O_SRC_PATH \
    && cd $H2O_SRC_PATH \
    && cmake -DCMAKE_INSTALL_PREFIX=$H2O_PREFIX . \
    && make \
    && make install \
    && rm -r $H2O_SRC_PATH

EXPOSE 7890

