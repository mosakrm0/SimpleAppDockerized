# GitHub Actions Task

## 1. Build a Workflow that builds container image and pushes it to private dokcer registry
### 1. Add credentials
Get your Dockerhub username and password and put it in Repository variables.

### 2. Building the Workflow
```
name: Docker Image CI

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:

  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v4

    - name: Login to Docker Hub
      uses: docker/login-action@v3
      with:
        username: ${{ vars.DOCKERUSER }}
        password: ${{ secrets.DOCKERHUBT }}

    - name: Build and push
      uses: docker/build-push-action@v6
      with:
        push: true
        tags: mosakrmoov/mosakrmoov

            
    - name: Push to Docker
      run: docker push mosakrmoov/mosakrmoov
```

## 2. Turn On Slack Notifications for Workflow
### 1. Inside Slack, Get The Endid App
### 2. Configure it with your github account and the repositroy you want it to check
### 3. Cofigure it with the channel you wann get notify at
### 4. Start a workflow and test it

![image](https://github.com/user-attachments/assets/1ed7ad1c-8d5b-459c-a8b4-0fe84279174e)

