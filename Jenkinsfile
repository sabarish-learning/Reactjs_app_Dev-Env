pipeline {
agent { label 'Dev-Agent node' } 
  environment {
	   LOGIN_CREDS = credentials('261b4bc0-b4a4-471f-a23c-0821e2dd462d')
    }
stages{
stage('Checkout')
{
steps{
checkout scm: scmGit(branches: [[name: '*/master'], [name: '*/dev']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/sabarish-learning/Reactjs_app_Dev-Env']])
}
}
	    stage('Debug Information') {
    steps {
        sh 'echo "currentbranch : $(git rev-parse --abbrev-ref HEAD)"'
        sh 'echo "BRANCH_NAME: $BRANCH_NAME"'
        sh 'git branch'
        sh 'ls -l'
    }
}
    stages {
        stage('Build and Push Docker Image (Dev)') {
            when {
                changeset "origin/dev"
            }
            steps {
                script {
                      sh './script/build_dev.sh'
                      sh 'echo done'
                    }
                }
            }
        }

        stage('Build and Push Docker Image (Prod)') {
            when {
                changeset "origin/master"
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
