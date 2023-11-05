pipeline {
agent { 
label 'Dev-Agent node' 
} 
environment {
LOGIN_CREDS = credentials('261b4bc0-b4a4-471f-a23c-0821e2dd462d')  
}
stages{
stage('Checkout')
{
steps{
checkout scm
}
}
    stage('Build and Push Docker Image') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'dev') {
                        sh './script/build_dev.sh'
                    } else if (env.BRANCH_NAME == 'master') {
                        sh './script/build_prod.sh'
                    } else {
                        echo "Branch not configured for Docker image build."
                    }
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
    script {
        if (env.BRANCH_NAME == 'master') {
              sh './script/deploy.sh'
        } else {
            echo "Branch not configured for Docker image build."
             }
         }
     }
    }
}	
post {
always {
sh 'docker logout'
}
}
}
