node(){
  def GIT_URL='$GIT_URL'
  def GIT_BRANCH='$GIT_BRANCH'
  echo "this is test branch"
  properties([parameters([string(defaultValue: 'https://github.com/bhanuprakash678910/mavenproj.git', description: 'GIT_URL', name: 'GIT_URL', trim: false), string(defaultValue: 'master', description: 'GIT_BRANCH', name: 'GIT_BRANCH', trim: false)])])
  
  stage("init"){
     echo "this is test branch"
    checkout([$class: 'GitSCM', branches: [[name: '*/${GIT_BRANCH}']], extensions: [], userRemoteConfigs: [[url: '${GIT_URL}']]])
    }
}
