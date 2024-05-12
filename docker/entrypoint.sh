#!/bin/bash

# Setup ROS environment
source /opt/ros/humble/setup.bash

# Define variables for the repository and package
REPO_URL="https://github.com/openroboticmetaverse/tdsi_moveit"
PACKAGE_NAME="tdsi_moveit"
LAUNCH_FILE="tdsi_moveit_controller.launch.py"

# Setup ROS environment
source /opt/ros/humble/setup.bash

# Create and build the workspace
mkdir -p ~/ros_ws/src
cd ~/ros_ws/src
git clone $REPO_URL
cd ..
colcon build --packages-select $PACKAGE_NAME
source install/setup.bash


# Start ROSBridge WebSocket server
ros2 launch rosbridge_server rosbridge_websocket_launch.xml port:=$ROSBRIDGE_PORT > /var/log/rosbridge.log 2>&1 &

# Start MoveIt2 Servo controller
ros2 launch $PACKAGE_NAME $LAUNCH_FILE > /var/log/$PACKAGE_NAME.log 2>&1 &

jobs

# Function to handle SIGTERM sent by Docker stop command
function shutdown {
    echo "Container stopping, terminating processes..."
    kill -SIGTERM $(jobs -p)
    wait
    echo "Container stopped."
}

# Trap SIGTERM to cleanup processes
trap shutdown SIGTERM

# Wait for any process to exit
wait -n

# If any process exits, exit this script and terminate remaining processes
shutdown
