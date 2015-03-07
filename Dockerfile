#
# Copyright 2015, Clinton Freeman
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
FROM ubuntu:14.04

MAINTAINER Clinton Freeman

RUN apt-get update

RUN apt-get -y install arduino
RUN apt-get -y install arduino-core
RUN apt-get -y install build-essential
RUN apt-get -y install git
RUN apt-get -y install python
RUN apt-get -y install python-configobj
RUN apt-get -y install python-jinja2
RUN apt-get -y install minicom
RUN apt-get -y install wget
RUN wget https://bootstrap.pypa.io/ez_setup.py -O - | python - –user

WORKDIR /glob
RUN wget https://pypi.python.org/packages/source/g/glob2/glob2-0.4.1.tar.gz
RUN gunzip -c glob2-0.4.1.tar.gz | tar xf -

WORKDIR /glob/glob2-0.4.1
RUN python setup.py install

WORKDIR /serial
RUN wget https://pypi.python.org/packages/source/p/pyserial/pyserial-2.7.tar.gz
RUN gunzip -c pyserial-2.7.tar.gz | tar xf -

WORKDIR /serial/pyserial-2.7
RUN python setup.py install

WORKDIR /ino

RUN git clone git://github.com/amperka/ino.git
WORKDIR /ino/ino
RUN ls -a
RUN make install

WORKDIR /arduino
RUN ino init

COPY src/ /arduino/src/
COPY lib/ /arduino/lib/
RUN ino build -m mega2560
