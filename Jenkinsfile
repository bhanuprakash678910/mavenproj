node("slave1") {
 def GIT_BRANCH= '$GIT_BRANCH'
 def TOMCAT_URL= '$TOMCAT_URL'
 def TOMCAT_PORT= '$TOMCAT_PORT'
  stage("git download"){ 
   checkout([$class: 'GitSCM', branches: [[name: "*/${GIT_BRANCH}"]], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/bhanuprakash678910/mavenproj.git']]])
  }
  stage("maven build"){ 
   sh 'mvn package'
  }
  stage("deployment"){ 
   deploy adapters: [tomcat9(credentialsId: 't2', path: '', url: "${params.TOMCAT_URL}:${params.TOMCAT_PORT}")], contextPath: 'qaenv', war: '**/*.war'
  }
}
