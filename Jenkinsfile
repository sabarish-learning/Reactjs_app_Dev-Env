pipeline {
agent { label 'Dev-Agent node' } 
  environment {
	   LOGIN_CREDS = credentials('261b4bc0-b4a4-471f-a23c-0821e2dd462d')
	  BRANCH_NAME = git rev-parse --abbrev-ref HEAD
    }
stages{
stage('Checkout')
{
steps{
checkout scmGit(branches: [[name: '*/master'], [name: '*/dev']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/sabarish-learning/Reactjs_app_Dev-Env']])
}
}
        stage('Build and Push Docker Image (Dev)') {
            when {
		 expression { env.BRANCH_NAME == 'dev' }
            }
            steps {
                script {
                      sh './script/build_dev.sh'
                      sh 'echo done'
                    }
                }
            }
        stage('Build and Push Docker Image (Prod)') {
            when {
		 expression { env.BRANCH_NAME == 'master' }
            }
            steps {
                script {
                      sh './script/build_prod.sh'
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
