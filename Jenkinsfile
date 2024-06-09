node("ajaynode") {
 stage("git init-GITHUB"){
   checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/bhanuprakash678910/mavenproj.git']])
 }
 stage("build-MAVEN"){
   sh 'mvn clean package '
 }
 stage("analysis-SONARQUBE"){
  sh '''mvn clean verify sonar:sonar \
  -Dsonar.projectKey=test123 \
  -Dsonar.projectName='test123' \
  -Dsonar.host.url=http://100.25.162.211:9000 \
  -Dsonar.token=sqp_986bb7329a327f5a0cb70270afecc6ffa911600c'''
 }
 stage("publish artifacts-NEXUS"){
    nexusArtifactUploader artifacts: [[artifactId: '$BUILD_TIMESTAMP', classifier: '', file: 'webapp/target/webapp.war', type: 'war']], credentialsId: 'NEXUS', groupId: 'QA', nexusUrl: '54.157.153.147:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'nexusrepo', version: '$BUILD_ID'
 }
 stage("deployment-TOMCAT"){
   deploy adapters: [tomcat9(credentialsId: 'TOMCAT', path: '', url: 'http://54.162.0.120:8080/')], contextPath: 'qaenv', war: '**/*.war'
 }
}

