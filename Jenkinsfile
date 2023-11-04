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
stage('Build and push docker image'){
steps{
script{
sh './script/build_and_push.sh'
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
when {
  anyOf {
   branch 'master'
   changeset '**/master/**'
    }
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
