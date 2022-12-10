pipeline {
  agent {
    label 'slave1'
  }
  stages{
	stage("maven"){
	  steps {
	    sh 'mvn package'
	  }
	}

  }
}
