# Use the MoveIt 2 Humble release as the base image
FROM moveit/moveit2:humble-release

# Update and install ROSBridge
RUN apt-get update && \
    apt-get install -y ros-humble-rosbridge-suite && \
    rm -rf /var/lib/apt/lists/*

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]

# Set a default command, in case one isn't provided
CMD ["bash"]
