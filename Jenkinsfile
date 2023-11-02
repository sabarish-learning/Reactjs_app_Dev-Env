pipeline {
agent { label 'Dev-Agent node' }
stages{
stage('Checkout'){
steps{
checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'git_jenkins_key', url: 'https://github.com/sabarish-learning/Reactjs_app_Dev-Env']])
 }
}

stage('Build'){
steps{
sh 'sudo docker build -t sabarish24/react-prod:1.0 .'
 }
}
stage('Push'){
steps{
withCredentials([usernamePassword(credentialsId: '261b4bc0-b4a4-471f-a23c-0821e2dd462d', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
sh 'sudo docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}'
sh 'sudo docker login -u sabarish24 -p @Leokanguva24$'
sh 'sudo docker push sabarish24/react-prod:1.0'
}
 }
}
stage('Test image') {
steps {
echo 'testing…'
sudo 'docker pull sabarish24/react-prod:1.0'
sh 'sudo docker inspect - type=image sabarish24/react-prod:1.0 '
 }
}
stage('Deploy'){
steps{
echo 'deploying on another server'
sh 'sudo docker stop react-prod || true'
sh 'sudo docker rm react-prod || true'
sh 'sudo docker run -d - name react-prod -p 80:80 sabarish24/react-prod:1.0'
sh '''
ssh -i Instancekey01.pem -o StrictHostKeyChecking=no ubuntu@3.110.120.75 <<EOF
sh 'sudo docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}'
sudo docker pull sabarish24/demo_repo/nodo-todo-app-test:latest
sudo docker stop react-prod || true
sudo docker rm react-prod || true
sudo docker run -d - name react-prod -p 5000:5000 sabarish24/react-prod:1.0
'''
     }
    }
  }
}
