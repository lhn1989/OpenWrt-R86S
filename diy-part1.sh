#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# openclash var
OPENCLASH_DIR="openclash"
OPENCLASH_GIT="https://github.com/vernesong/OpenClash.git"
OPENCLASH_SRC="luci-app-openclash"
OPENCLASH_BRANCH="master"

# git shallow clone
shallowClone(){
    mkdir -p /workdir/$1
    cd /workdir/$1
    git init
    git remote add origin $2
    git config core.sparsecheckout true
    echo $3 >> .git/info/sparse-checkout
    git pull --depth 1 origin $4
}

# Print Commands
set -x

# Add SSR
sed -i "/helloworld/d" "feeds.conf.default"
echo "src-git helloworld https://github.com/fw876/helloworld.git" >> "feeds.conf.default"

# Add subconverter
echo "src-git cussubconverter https://github.com/lhn1989/luci-app-cussubconverter.git" >> "feeds.conf.default"

# Add subconverter
echo "src-git subconverter https://github.com/tindy2013/openwrt-subconverter.git" >> "feeds.conf.default"

cat feeds.conf.default
sleep 10

# Add openclash
shallowClone $OPENCLASH_DIR $OPENCLASH_GIT $OPENCLASH_SRC $OPENCLASH_BRANCH
mv /workdir/$OPENCLASH_DIR/$OPENCLASH_SRC /workdir/openwrt/package/
rm -rf /workdir/$OPENCLASH_DIR
