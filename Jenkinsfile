pipeline {
 agent any
  environment {
	   LOGIN_CREDS = credentials('261b4bc0-b4a4-471f-a23c-0821e2dd462d')
    }
stages{
stage('Checkout'){
steps{
checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'git_jenkins_key', url: 'https://github.com/sabarish-learning/Reactjs_app_Dev-Env']])
 }
}
stage('Build Docker'){
steps{
script{
sh '''
echo 'build Docker image'
docker build -t sabarish24/react-prod:1.0 -f ./Dockerfile.prod .
'''
}
 }
}
stage('Test image') {
steps {
echo 'testing…'
sh 'sudo docker pull sabarish24/react-prod:1.0'
sh 'sudo docker inspect - type=image sabarish24/react-prod:1.0 '
 }
}
stage('Push'){
steps{
sh 'sudo docker login -u $LOGIN_CREDS_USR -p $LOGIN_CREDS_PSW'
sh 'sudo docker push sabarish24/react-prod:1.0'
 }
}
stage('Deploy'){
steps{
echo 'deploying on another server'
sh 'sudo docker login -u $LOGIN_CREDS_USR -p $LOGIN_CREDS_PSW'
sh 'sudo docker pull sabarish24/react-prod:1.0'
sh 'sudo docker stop react-prod || true'
sh 'sudo docker rm react-prod || true'
sh 'sudo docker run -d - name react-prod -p 8080:80 sabarish24/react-prod:1.0'
     }
    }
  }
}
