pipeline {
agent { 
label 'Dev-Agent node' 
} 
environment {
LOGIN_CREDS = credentials('261b4bc0-b4a4-471f-a23c-0821e2dd462d')  
BRANCH_NAME = 'env.BRANCH_NAME'
}
stages{
stage('Checkout')
{
steps{
checkout scmGit(branches: [[name: '*/master'], [name: '*/dev']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/sabarish-learning/Reactjs_app_Dev-Env']])
}
}
stage('Build and Push Docker Image') {
steps {
script {
sh './script/build.sh'
sh 'echo done'
}
}
}
stage('Test image') {
steps {
sh './script/test.sh'
 }
}	
stage('Deploy'){
steps{
sh './script/deploy.sh'
     }
    }
}	
post {
always {
sh 'docker logout'
}
}
}
