#!/bin/bash

# Setup ROS environment
source /opt/ros/humble/setup.bash

# Start ROSBridge WebSocket server
ros2 launch rosbridge_server rosbridge_websocket_launch.xml > /var/log/rosbridge.log 2>&1 &

# Start MoveIt2 Servo controller
ros2 launch moveit_servo servo_example.launch.py > /var/log/moveit_servo.log 2>&1 &

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
