pipeline {
agent {
 label 'slave1'
}
stages{
 stage("git init"){
   steps {
  checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/bhanuprakash678910/mavenproj.git']]])
  }
 }
 stage("maven build"){
   steps{
    sh '''mvn package'''
   }
 }
 stage("code analysis"){
    steps {
   sh '''mvn  sonar:sonar \\
  -Dsonar.projectKey=testproject \\
  -Dsonar.host.url=http://54.173.70.200:9000 \\
  -Dsonar.login=sqp_e39733e9a457dcb9c2eb5126983298c71e7bd695'''
  }
 }
 stage("artifactstorage"){
   steps {
   nexusArtifactUploader artifacts: [[artifactId: '$BUILD_TIMESTAMP', classifier: '', file: 'webapp/target/webapp.war', type: 'war']], credentialsId: 'NEXUS3CREDS', groupId: 'PREPROD', nexusUrl: '44.204.58.3:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'testrepo', version: '$BUILD_ID'
 }
 }
 stage("deployment"){
    steps {
   deploy adapters: [tomcat9(credentialsId: 'tomcat2creds', path: '', url: 'http://3.86.149.98:8080/')], contextPath: 'preprod', onFailure: false, war: '**/*.war'
   }
  }
 }
}
