node(){
 def GIT_URL='$GIT_URL'
 def GIT_BRANCH='$GIT_BRANCH'
 def MAVEN_GOAL='$MAVEN_GOAL'
 def SONAR_URL='$SONAR_URL'
 def ARTIFACT_URL='$ARTIFACT_URL'
 def TOMCAT_URL='$TOMCAT_URL'
 def TOMCAT_PORT='$TOMCAT_PORT'
 properties([pipelineTriggers([githubPush()])])
 properties([parameters([string(defaultValue: 'https://github.com/bhanuprakash678910/mavenproj.git', description: 'GIT_URL', name: 'GIT_URL', trim: false),
  string(defaultValue: 'master', description: 'GIT_BRANCH', name: 'GIT_BRANCH', trim: false),
  string(defaultValue: 'package', description: 'MAVEN_GOAL', name: 'MAVEN_GOAL', trim: false),
  string(defaultValue: 'http://18.207.237.185:9000', description: 'SONAR_URL', name: 'SONAR_URL', trim: false),
  string(defaultValue: 'http://18.207.237.185:8081', description: 'ARTIFACT_URL', name: 'ARTIFACT_URL', trim: false),
  string(defaultValue: 'http://54.161.103.198', description: 'TOMCAT_URL', name: 'TOMCAT_URL', trim: false),
  string(defaultValue: '8080', description: 'TOMCAT_PORT', name: 'TOMCAT_PORT', trim: false)])])

 stage("git init"){
    checkout([$class: 'GitSCM', branches: [[name: '*/${GIT_BRANCH}']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: '${GIT_URL}']]])
 }
 stage("build"){
   sh 'mvn ${MAVEN_GOAL}'
 }
 stage("codeanalysis"){
    sh '''mvn sonar:sonar \\
  -Dsonar.projectKey=mavenproj \\
  -Dsonar.host.url=${SONAR_URL} \\
  -Dsonar.login=a94c8c3c8a89690c8cdb8b436f61a599176ac684'''
 }
 stage("push artifact"){
   sh '''cp webapp/target/webapp.war webapp/target/webapp-$BUILD_ID.war
curl -u admin:Admin@1234 -T webapp/target/webapp-$BUILD_ID.war "${ARTIFACT_URL}/artifactory/mavenproj34/webapp-$BUILD_ID.war "'''
 }
 stage("deploy"){
  deploy adapters: [tomcat9(credentialsId: 'tomcat_user', path: '', url: "${params.TOMCAT_URL}:${params.TOMCAT_PORT}")], contextPath: 'qaenv2', war: '**/*.war'
 }
}
