node('slave1'){
stage("git init"){
  checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/bhanuprakash678910/mavenproj.git']])
 }
stage("maven build"){
  sh 'mvn package'
 }
}
