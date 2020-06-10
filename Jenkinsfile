pipeline {
  environment {
    registry = "ankababu/hello"
    registryCredential = 'docker-hub'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/ankababug/boxfuse-sample-java-springboot-hello.git'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('deploy to k8s') {
      steps{
        sshagent(['kops-machine']){
          sh "scp -o StrictHostKeyChecking=no pods.yml centos@172.31.0.218:/home/centos/"
          script{
              try{
                 sh "ssh centos@172.31.0.218 kubectl apply -f ."
              }catch(error){
                 sh "ssh centos@172.31.0.218 kubectl create -f ."
              }
           }
        }
      }
    }
  }
}
