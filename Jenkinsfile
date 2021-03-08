node(){
  def GIT_URL='$GIT_URL'
  def GIT_BRANCH='$GIT_BRANCH'
  def MAVEN_GOAL='$MAVEN_GOAL'
  def SONAR_URL='$SONAR_URL'
  def ARTIFACT_URL='$ARTIFACT_URL'
  def TAG='$TAG'

  properties([parameters([
   string(defaultValue: 'https://github.com/bhanuprakash678910/mavenproj.git', description: ' GIT_URL', name: ' GIT_URL', trim: false), 
   string(defaultValue: 'test', description: 'GIT_BRANCH', name: 'GIT_BRANCH', trim: false), 
   string(defaultValue: 'package', description: 'MAVEN_GOAL', name: 'MAVEN_GOAL', trim: false), 
   string(defaultValue: 'http://44.192.23.210:9000', description: 'SONAR_URL', name: 'SONAR_URL', trim: false), 
   string(defaultValue: 'http://44.192.23.210:8081', description: 'ARTIFACT_URL', name: 'ARTIFACT_URL', trim: false), 
   string(defaultValue: '2.0', description: 'TAG', name: 'TAG', trim: false)])
  ])
 stage("init"){
   checkout([$class: 'GitSCM', branches: [[name: '*/${GIT_BRANCH}']], extensions: [], userRemoteConfigs: [[url: '${GIT_URL}']]])
 }
 stage("build"){
  sh 'mvn ${MAVEN_GOAL}'
 }
 stage("code analysis"){
  sh '''mvn sonar:sonar \\
  -Dsonar.projectKey=mavenproj \\
  -Dsonar.host.url=${SONAR_URL} \\
  -Dsonar.login=9a97145fac38792c9576bc39e8d97ed91085f20b'''
 }
 stage("push artifact"){
   sh '''cp webapp/target/webapp.war webapp/target/webapp-$BUILD_ID.war
   curl -u admin:Admin123 -T webapp/target/webapp-$BUILD_ID.war "${ARTIFACT_URL}/artifactory/mavenproj/webapp-$BUILD_ID.war"'''
 }
 stage("Docker"){
    sh '''docker build -t demo:${TAG} .
'''
  }
}
