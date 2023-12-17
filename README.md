# docker-autobox

# Docker Image Creation and Automation Guide

Welcome to our Docker Image Automation repository! This guide is designed to help you learn how to build a Docker image with Ubuntu, Python, Ansible, and Terraform, and to set up an automated process for keeping it updated using GitHub Actions.

## Dockerfile Explanation

Below is a detailed explanation of each directive in the Dockerfile:

### Base Image

FROM ubuntu:latest

This line sets the base image for the Docker container as the latest version of Ubuntu.

### Maintainer Label

LABEL maintainer="your.email@example.com"

This LABEL instruction adds a metadata label with the maintainer's email. It's good practice to label your images for better organization and maintainability.

### Package Installation

RUN apt-get update && apt-get install -y \
    software-properties-common \
    python3-pip \
    wget \
    unzip

Here, we're updating the package list of the Ubuntu image and installing necessary packages: software-properties-common (for managing PPAs), python3-pip (for installing Python packages), wget (for downloading files), and unzip (for extracting zip files).

### Python and Ansible Core Installation

RUN apt-get install -y python3 && \
    pip3 install ansible-core==2.16.0

This step installs Python 3 and Ansible Core 2.16.0. Python 3 is installed using apt-get, and Ansible is installed using Python's package manager pip.

### Terraform Installation

RUN wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip && \
    unzip terraform_1.6.6_linux_amd64.zip -d /usr/local/bin/ && \
    rm -f terraform_1.6.6_linux_amd64.zip

In this step, Terraform 1.6.6 is downloaded and installed. The binary is extracted to /usr/local/bin, making it available in the system path.

### Cleanup

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

This command cleans up the apt cache and removes unnecessary files to keep the image size down.

### Working Directory

WORKDIR /workspace

Sets the working directory to /workspace inside the container.

### Default Command

CMD ["bash"]

Finally, this specifies the default command to run when the container starts, which in this case is a Bash shell.

## Building the Docker Image

To build the Docker image, navigate to the directory containing the Dockerfile and run:

docker build -t your-image-name:your-tag .

Replace your-image-name and your-tag with your preferred image name and tag.

## Automating Docker Image Updates with GitHub Actions

The repository includes a GitHub Actions workflow defined in .github/workflows/docker-build.yml. This workflow automates the building and updating of the Docker image.

### Workflow Overview

The workflow is triggered on two occasions:
1. A push to the main branch that changes the Dockerfile.
2. Automatically at midnight every day.

It includes steps to check out the repository, set up Docker Buildx, log in to DockerHub, build the Docker image, and push it to DockerHub.

### Setting Up the Workflow

To use this workflow:
1. Fork this repository.
2. Add your DockerHub username and token as secrets in your repository settings.
3. Make any changes to the Dockerfile and push them to trigger the workflow.
4. Monitor the Actions tab to see the workflow in action.

## Conclusion

This guide provides a detailed explanation of the Dockerfile and the GitHub Actions workflow used for automating Docker image builds. It's a great starting point for anyone looking to dive into Docker image creation and CI/CD automation.
