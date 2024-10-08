# Docker Installation Guide for Windows

## Introduction
Docker is a platform for developing, shipping, and running applications inside containers. Containers are lightweight and contain everything needed to run an application, making them ideal for microservices and distributed applications. This guide will walk you through the steps to install Docker on a Windows machine.

## Prerequisites
Before you begin, ensure you have the following:
- Windows 10 64-bit: Pro, Enterprise, or Education (Build 16299 or later)
- Hyper-V and Containers Windows features must be enabled
- Administrative privileges on the machine

## Step-by-step Installation

### Step 1: Enable Hyper-v and Containers
1. Press `Windows + R` to open the Run dialog.
2. Type `optionalfeatures.exe` and press Enter.
3. In the Windows Features dialog, check `Hyper-V` and `Containers`.
4. Click `OK` and restart your computer if prompted.

### Step 2: Download Docker Desktop for Windows
1. Open your web browser and go to the Docker Desktop download page: [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
2. Click on the "Download for Windows" button.

![Download Docker Desktop](https://www.docker.com/sites/default/files/d8/2019-07/docker-desktop-windows.png)

### Step 3: Install Docker Desktop
1. Locate the downloaded `Docker Desktop Installer.exe` file and double-click it to start the installation.
2. When the Docker Desktop installation wizard starts, follow the on-screen instructions.
   - The default options are usually fine.
   - Ensure the option to use WSL 2 instead of Hyper-V is checked if you prefer to use WSL 2.

### Step 4: Start Docker Desktop
1. Once the installation is complete, Docker Desktop will start automatically. If it doesn't, you can start it from the Start menu.
2. Docker Desktop will prompt you to log in to your Docker account. If you don't have an account, you can create one for free.

### Step 5: Verify the Installation
1. Open a Command Prompt or PowerShell window.
2. Type the following command and press Enter:
    ```sh
    docker --version
    ```
3. You should see the Docker version number displayed, confirming that Docker has been installed successfully.

### Step 6: Test Docker Installation
1. Run the following command to test Docker by running a simple container:
    ```sh
    docker run hello-world
    ```
2. Docker will download the `hello-world` image from Docker Hub and run it in a container. You should see a message indicating that Docker is working correctly.

## Additional Configuration

### Using Wsl 2 (Optional)
If you chose to use WSL 2 during the installation, you might need to perform additional setup:

1. Ensure WSL 2 is installed and set as the default version:
    ```sh
    wsl --set-default-version 2
    ```
2. Integrate Docker with WSL 2 by setting up a WSL 2 distro (e.g., Ubuntu) and enabling it in Docker Desktop settings:
    - Open Docker Desktop settings.
    - Go to the `Resources` section and then `WSL Integration`.
    - Enable Docker integration for your chosen WSL 2 distro.

### Configure Docker to Start on Boot
1. Open Docker Desktop settings.
2. Go to the `General` section.
3. Check the box for `Start Docker Desktop when you log in`.

## Conclusion
Congratulations! You have successfully installed Docker on your Windows machine. You are now ready to start creating and running containers. For further learning, consider exploring the Docker documentation and tutorials.
