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

TEMP_DIR=${ROOT_DIR}/template
BIN_DIR=${ROOT_DIR}/bin
CACHE_DIR=${ROOT_DIR}/cache

MARK_STR="# added by cupkee-cli setup.sh"

mkdir -p ${CACHE_DIR}

# clone or update cupkee platform
if [ ! -d ${CACHE_DIR}/cupkee ]; then
    echo "Starting clone cupkee data, please wait ..."
    git clone  https://github.com/cupkee/cupkee.git ${CACHE_DIR}/cupkee
    if [ ! $? -eq 0 ];
    then
        exit;
    fi
fi

# setup cupkee platform
echo "Starting setup cupkee env-bin, please wait ..."
docker run --rm -v ${ROOT_DIR}/env-bin:/home/cupkee/platform cupkee/env-build npm install
if [ ! $? -eq 0 ];
then
    exit;
fi

echo "Starting setup cupkee data, please wait ..."
docker run --rm -v ${CACHE_DIR}/cupkee:/home/cupkee/platform cupkee/env-build make setup
if [ ! $? -eq 0 ];
then
    exit;
fi

# create cupkee main client command
sed -e "s#cupkee_install_path#${ROOT_DIR}#" ${TEMP_DIR}/cupkee.main.template 1> ${BIN_DIR}/cupkee
chmod a+x ${BIN_DIR}/cupkee

# set user PATH
## Todo: probe profile name base on OS

if [ -e ~/.bash_profile ]; then
    USR_PROFILE=~/.bash_profile
elif [ -e ~/.bashrc ]; then
    USER_PROFILE=~/.bashrc
else
    USER_PROFILE=~/.profile
fi

if ! grep -Fxq "${MARK_STR}" ${USR_PROFILE}
then
    echo ${MARK_STR} >> ${USR_PROFILE}
    echo "export PATH=\$PATH:${BIN_DIR}"  >> ${USR_PROFILE}
fi

# setup complete
echo "Setup OK"

