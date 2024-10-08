# Beginner's Guide to Main Git Commands on Windows

## Introduction
Git is a powerful version control system used to manage and track changes in your code. This guide will cover the basic Git commands that every beginner should know, providing a solid foundation for working with Git on Windows.

## Prerequisites
- Git installed on your Windows machine. If you haven't installed it yet, refer to the [Git Installation Guide](#).
- Basic understanding of command-line interface (CLI).

## Setting Up Git

### Configure Git
Before using Git, configure your username and email. These details will be associated with your commits.

1. Open Git Bash.
2. Set your username:
    ```sh
    git config --global user.name "Your Name"
    ```
3. Set your email:
    ```sh
    git config --global user.email "youremail@example.com"
    ```

## Main Git Commands

### Initialize a Repository
To start tracking a project with Git, you need to initialize a Git repository.

1. Navigate to your project directory:
    ```sh
    cd path/to/your/project
    ```
2. Initialize the repository:
    ```sh
    git init
    ```

### Clone a Repository
To work on an existing project, you can clone a repository from a remote source.

1. Clone the repository:
    ```sh
    git clone https://github.com/username/repository.git
    ```

### Check the Repository Status
To see the status of your working directory and the staging area:

1. Check status:
    ```sh
    git status
    ```

### Add Changes
To add changes to the staging area:

1. Add a specific file:
    ```sh
    git add filename
    ```
2. Add all changes:
    ```sh
    git add .
    ```

### Commit Changes
To save changes to the local repository:

1. Commit changes with a message:
    ```sh
    git commit -m "Your commit message"
    ```

### View Commit History
To view the history of commits:

1. Show commit history:
    ```sh
    git log
    ```

### Create a Branch
To create a new branch for development:

1. Create a branch:
    ```sh
    git branch branchname
    ```
2. Switch to the new branch:
    ```sh
    git checkout branchname
    ```

### Merge Branches
To merge changes from one branch into another:

1. Switch to the branch you want to merge into:
    ```sh
    git checkout main
    ```
2. Merge the branch:
    ```sh
    git merge branchname
    ```

### Push Changes
To push your commits to a remote repository:

1. Push changes to the remote repository:
    ```sh
    git push origin branchname
    ```

### Pull Changes
To pull changes from a remote repository:

1. Pull changes from the remote repository:
    ```sh
    git pull origin branchname
    ```

### Resolve Merge Conflicts
If there are conflicts during a merge, Git will prompt you to resolve them.

1. Open the conflicting files and resolve the conflicts.
2. Add the resolved files to the staging area:
    ```sh
    git add filename
    ```
3. Commit the resolved changes:
    ```sh
    git commit -m "Resolved merge conflicts"

## Conclusion
These are the basic Git commands that you need to get started with version control. As you become more comfortable with Git, you'll discover additional commands and workflows to enhance your productivity. For more in-depth learning, consider exploring the official [Git documentation](https://git-scm.com/doc) and other resources.

---

Feel free to customize this guide based on the specific needs of your project or team. If you need any additional details or specific use cases covered, let me know!