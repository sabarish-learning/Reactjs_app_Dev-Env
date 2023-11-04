pipeline {
agent { label 'Dev-Agent node' } 
  environment {
	   LOGIN_CREDS = credentials('261b4bc0-b4a4-471f-a23c-0821e2dd462d')
    }
stages{
stage('Checkout'){
steps{
checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'git_jenkins_key', url: 'https://github.com/sabarish-learning/Reactjs_app_Dev-Env']])
 }
}
stage('Build and push to dev repo'){
when {
   anyOf {
   branch 'dev'
   changeset '**/dev/**'
     }
   }
steps{
script{
sh './script/build_dev.sh'
}
 }
 }
 
 stage('Build and push to prod repo') {
 
when {
   changeset '**/master/**'
    }
steps{
script{
sh './script/build_prod.sh'
}
}
}
stage('Test image') {
steps {
sh './script/test.sh'
 }
}
stage('Deploy'){
when {
   changeset '**/master/**'
    }
steps{
sh './script/deploy_to_Ec2.sh'
     }
    }
  }
post {
 always {
	sh 'docker logout'
		}
	}
}
