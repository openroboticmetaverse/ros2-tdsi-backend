<p align="center">
  <a href="https://www.openroboticmetaverse.org">
    <img alt="orom" src="https://raw.githubusercontent.com/openroboverse/knowledge-base/main/docs/assets/icon.png" width="100" />
  </a>
</p>
<h1 align="center">
  🤖 open robotic metaverse - tdsi demo 🌐
</h1>

## Overview 🔍

This repository hosts the Docker configuration and supporting scripts necessary to create a Docker image that integrates ROS 2 with MoveIt 2 and Rosbridge.
The primary function is to control a Franka Emika robot using MoveIt Servo and send the joint states to frontend applications via a ROSBridge WebSocket server.

## Setup ⚙️

1. Clone the Repo 📥

```bash
git clone git@github.com:openroboticmetaverse/ros2-tdsi-backend.git
```

```bash
cd ros2-tdsi-backend
```

2. Run the following script to automatically determine joytick device ID 🕹️

```bash
./configure.sh
```

3. Run Docker Compose 🐳

```bash
docker compose up -d
```

## Usage 💻

The WebSocket server is available at `ws://localhost:9090`.
