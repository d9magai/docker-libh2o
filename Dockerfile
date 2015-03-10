FROM d9magai/libuv
MAINTAINER d9magai

ENV H2O_PREFIX /opt/h2o
ENV H2O_SRC_PATH $H2O_PREFIX/src
ENV H2O_LIBRARY_PATH $H2O_PREFIX/lib
ENV H2O_INCLUDE_PATH $H2O_PREFIX/include

RUN mkdir -p $H2O_SRC_PATH $H2O_LIBRARY_PATH $H2O_INCLUDE_PATH

RUN yum update -y && yum install -y \
    gcc-c++ \
    cmake \
    git \
    openssl-devel \
    libyaml-devel \
    && yum clean all

RUN git clone --recursive https://github.com/h2o/h2o $H2O_SRC_PATH \
    && cd $H2O_SRC_PATH \
    && cmake . \
    && make libh2o \
    && install libh2o.a $H2O_LIBRARY_PATH \
    && cp -r $H2O_SRC_PATH/include/* $H2O_INCLUDE_PATH \
    && rm -r $H2O_SRC_PATH

EXPOSE 7890

