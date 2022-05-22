pipeline{
 agent any 
 parameters { 
string(name: 'GIT_URL', defaultValue: 'https://github.com/bhanuprakash678910/mavenproj.git', description: '') 
string(name: 'GIT_BRANCH', defaultValue: 'master', description: '') 
string(name: 'MAVEN_GOAL', defaultValue: 'install', description: '') 
}
   stages{
     stage("git init"){
        steps{
             checkout([$class: 'GitSCM', branches: [[name: '*/${GIT_BRANCH}']], extensions: [], userRemoteConfigs: [[url: '${GIT_URL}']]])
        }
     }
     stage("maven"){
        steps{
           sh 'mvn ${MAVEN_GOAL}'  
        }
     }
    stage("sonarqube"){
        steps{
           sh '''mvn sonar:sonar \\
  -Dsonar.projectKey=scriptedpipeline \\
  -Dsonar.host.url=http://52.90.237.11:9000 \\
  -Dsonar.login=46698932ba0a50914554bbf78904fc1dc91f2846'''    
        }
     }
    stage("nexus"){
        steps{
           nexusArtifactUploader artifacts: [[artifactId: '$BUILD_TIMESTAMP', classifier: '', file: 'webapp/target/webapp.war', type: 'war']], credentialsId: 'NEXUS_CREDS', groupId: 'DEV', nexusUrl: '54.173.42.60:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'nexus-releases', version: '$BUILD_ID'
        }
     }
     stage("tomcat"){
        steps{
              deploy adapters: [tomcat9(credentialsId: 'TOMCAT_CREDS', path: '', url: 'http://54.90.90.238:8080')], contextPath: 'devenvtest', war: '**/*.war'
        }
     }
   }
}

