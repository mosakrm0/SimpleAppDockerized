pipeline {
  agent any
  stages {
    stage('') {
      steps {
        sh '''docker build -t task1 .

docker image tag task1 mosakrmov01/task1:latest

docker push mosakrmov01/task1:latest'''
      }
    }

  }
}