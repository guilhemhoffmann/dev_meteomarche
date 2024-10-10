# Use an official Ubuntu base image
FROM ubuntu:latest

# Prevents prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y zsh git curl && \
    apt-get clean

# Install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Change default shell to zsh

# Set the working directory
WORKDIR /root

# By default, start zsh shell
CMD ["zsh"]
