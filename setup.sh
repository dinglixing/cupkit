#! /usr/bin/env bash

# MIT License
#
# Copyright (c) 2017 Lixing Ding <ding.lixing@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

ROOT_DIR=`pwd`
BIN_DIR=${ROOT_DIR}/bin
CACHE_DIR=${ROOT_DIR}/cache

mkdir -p ${CACHE_DIR}

# clone cupkee platform
echo "Starting clone cupkee data, please wait ..."
git clone  https://github.com/cupkee/cupkee.git ${CACHE_DIR}/cupkee

# setup cupkee platform
echo "Starting setup cupkee data, please wait ..."
cd ${CACHE_DIR}/cupkee && make setup

# set user PATH
echo "# added by cupkee-cli setup.sh" >> ~/.bash_profile
echo "export CUPKEE_ROOT=${ROOT_DIR}" >> ~/.bash_profile
echo "export PATH=\$PATH:${BIN_DIR}" >> ~/.bash_profile

# setup complete
echo "Setup OK"

