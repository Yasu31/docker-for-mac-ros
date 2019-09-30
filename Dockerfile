FROM ros:melodic
# install ros tutorials packages
RUN apt-get update && apt-get install -y
RUN apt-get install -y ros-melodic-ros-tutorials \
    ros-melodic-common-tutorials \
    && rm -rf /var/lib/apt/lists/