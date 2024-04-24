# Use the MoveIt 2 Humble release as the base image
FROM moveit/moveit2:humble-release

# Update and install ROSBridge
RUN apt-get update && \
    apt-get install -y ros-humble-rosbridge-suite && \
    rm -rf /var/lib/apt/lists/*

# (Optional) Set up any necessary environment variables, entrypoint, or default commands
#ENTRYPOINT ["/ros_entrypoint.sh"]
#CMD ["bash"]
