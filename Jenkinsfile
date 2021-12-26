def GIT_URL= '$GIT_URL'
def GIT_BRANCH='$GIT_BRANCH'
def MVN_GOAL='$MVN_GOAL'

node() {
    
timeout(15) {
   
}
 stage("git init"){
    checkout([$class: 'GitSCM', branches: [[name: '*/${GIT_BRANCH}']], extensions: [], userRemoteConfigs: [[url: '${GIT_URL}']]])
 }
 stage("maven build"){
  sh '${MVN_GOAL}'
 }
    
  stage("sonarqube"){
   sh '''mvn sonar:sonar \\
  -Dsonar.projectKey=mavenproj \\
  -Dsonar.host.url=http://3.143.115.227:9000 \\
  -Dsonar.login=9c176cc1aa7c3bd3df9a72fed0d77846738d930b'''
}

stage("artifactory") {
   sh ''' cp webapp/target/webapp.war webapp-$BUILD_ID.war
          curl -u admin:Admin@407429 -O "http://3.143.115.227:8081/artifactory/mavenproj/webapp-$BUILD_ID.war"
          rm webapp-$BUILD_ID.war '''
}
 stage("deployment"){
    deploy adapters: [tomcat9(credentialsId: 'tomcatnewcreds', path: '', url: 'http://3.14.1.103:8080/')], contextPath: 'qaenv', war: '**/*.war'
 }
}
