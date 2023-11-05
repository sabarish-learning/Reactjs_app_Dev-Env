pipeline {
agent { 
label 'Dev-Agent node' 
} 
environment {
LOGIN_CREDS = credentials('261b4bc0-b4a4-471f-a23c-0821e2dd462d')  
def MOST_RECENT_BRANCH = sh(
            script: '''\
                git for-each-ref --sort='-committerdate' --format="%(refname:short) %(committerdate:relative)" refs/remotes/origin/ | grep -v HEAD | head -n 1 | awk '{print $1}'
            ''',
            returnStdout: true
        ).trim()
}
stages{
stage('Checkout')
{
steps{
checkout scm
}
}
    stage('Debug Information') {
    steps {
        sh 'echo "$MOST_RECENT_BRANCH"'
        sh 'echo "BRANCH_NAME: $BRANCH_NAME"'
        sh 'git branch'
        sh 'ls -ltr'
        sh 'ls -ltr'
    }
}
    stage('Build and Push Docker Image') {
            steps {
                script {
               sh './script/build.sh'
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
              sh './script/deploy.sh'
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
