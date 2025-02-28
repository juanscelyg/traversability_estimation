#!/bin/bash

CATKIN_WS=/root/catkin_ws
mkdir -p src/repositories

echo "Cloning repositories ..."
vcs import src/repositories < src/traversability_estimation/config/custom_workspace.repos
rosdep install --from-paths . --ignore-src --rosdistro noetic -y > /dev/null

cd src/repositories/norlab_icp_mapper
SRC_DIR=${PWD}
BUILD_DIR=${SRC_DIR}/build
mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
cmake -D CMAKE_BUILD_TYPE=RelWithDebInfo -D BUILD_EXAMPLE=TRUE ${SRC_DIR}
make 
sudo make install

echo "catkin Build ..."
cd ${CATKIN_WS}
catkin build > /dev/null

echo "source devel/setup.bash ..."
source devel/setup.bash > /dev/null

echo "Setup ready!"