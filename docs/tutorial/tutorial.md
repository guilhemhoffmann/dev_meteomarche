---
type: tutorial
version: "0.2"
---

# Setting Up a Python Development Environment with Docker

This guide will show you how to create a development environment for Python using Docker, share a local folder to store your files, and run scripts from the command line.

## Step 1: Prepare Your Project Directory

Create a project directory on your local machine. For this example, we'll call it `python-docker-dev`.

```bash
mkdir python-docker-dev
cd python-docker-dev
```

## Step 2: Create a Python Script

Inside the `python-docker-dev` directory, create a simple Python script. We'll call it `app.py`.

```python
# app.py
print("Hello, Docker!")
```

## Step 3: Write a Dockerfile

Create a file named `Dockerfile` in the `python-docker-dev` directory with the following content:

```Dockerfile
# Use the official Python image from the Docker Hub
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
#COPY . .

# Install any needed packages specified in requirements.txt
# If you don't have any dependencies, you can skip this step
# RUN pip install --no-cache-dir -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Run app.py when the container launches
CMD ["python", "app.py"]
```

## Step 4: Create a docker-compose.yml File

Create a `docker-compose.yml` file in the same directory with the following content:

```yaml
version: '3'
services:
  python-app:
    build: .
    volumes:
      - .:/usr/src/app
    command: python app.py
```

## Step 5: Build and Run the Container

Open a terminal, navigate to the `python-docker-dev` directory, and run the following commands to build and start your Docker container:

```bash
# Build the Docker image
docker-compose build

# Start the container
docker-compose up
```

## Step 6: Connect to the Container

To connect to the running container, use the `docker exec` command. First, find the container ID or name using `docker ps`:

```bash
docker ps
```

Then, connect to the container:

```bash
docker exec -it <container_id_or_name> /bin/bash
```

## Step 7: Modify and Run Your Script

Since we mounted the current directory to `/usr/src/app` inside the container, any changes you make to files in the `python-docker-dev` directory will be reflected inside the container. To run the script again after making changes, you can either restart the container or run the command inside the connected container session:

```bash
python app.py
```

## Full Directory Structure

Here's what your `python-docker-dev` directory should look like:

```plaintext
python-docker-dev/
├── app.py
├── Dockerfile
└── docker-compose.yml
```

## Summary

You've created a Docker-based development environment for Python where:
- The local folder is shared with the container.
- The Python script can be run and modified easily.
- You can connect to the container and run commands interactively.

This setup helps maintain a consistent development environment and makes it easy to manage dependencies and configurations.
```

You can copy and paste this Markdown content into your MkDocs project. Save it as a `.md` file, and add it to your `mkdocs.yml` configuration file to integrate it into your documentation site.