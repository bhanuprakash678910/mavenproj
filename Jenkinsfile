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
 stage("deployment"){
    deploy adapters: [tomcat9(credentialsId: 'tomcatnewcreds', path: '', url: 'http://3.14.1.103:8080/')], contextPath: 'qaenv', war: '**/*.war'
 }
}
