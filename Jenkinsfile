node("slave1") {
 def GIT_BRANCH= 'master'
 def TOMCAT_URL= 'http://54.175.184.200'
 def TOMCAT_PORT= '8083'
  stage("git download"){ 
   checkout([$class: 'GitSCM', branches: [[name: "*/${GIT_BRANCH}"]], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/bhanuprakash678910/mavenproj.git']]])
  }
  stage("maven build"){ 
   sh 'mvn package'
  }
  stage("deployment"){ 
   deploy adapters: [tomcat9(credentialsId: 't2', path: '', url: "${TOMCAT_URL}:${TOMCAT_PORT}")], contextPath: 'qaenv', war: '**/*.war'
  }
}
