pipeline {
 agent {
   label 'slave1'
 }
 stages{
  stage("git") {
   steps {
   checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/bhanuprakash678910/mavenproj.git']])
    }
  }
 stage("maven") {
   steps {
  sh 'mvn package'
  }
}
 stage("sonarqube") {
   steps {
   sh '''mvn clean verify sonar:sonar \\
  -Dsonar.projectKey=testpro \\
  -Dsonar.projectName=\'testpro\' \\
  -Dsonar.host.url=http://54.174.114.249:9000 \\
  -Dsonar.token=sqp_ffcf40399ce3961eb74dbeedeccbeb8575c54b8e'''
  }
}
 stage("nexus") {
   steps {
    nexusArtifactUploader artifacts: [[artifactId: '$BUILD_TIMESTAMP', classifier: '', file: 'webapp/target/webapp.war', type: 'war']], credentialsId: 'NEXUS-CREDS', groupId: 'PROD', nexusUrl: '44.211.141.15:8081/', nexusVersion: 'nexus3', protocol: 'http', repository: 'testrepo', version: '$BUILD_ID'
  }
}
 stage("tomcat") {
    steps {
    deploy adapters: [tomcat9(credentialsId: 'TOMCAT_CREDS', path: '', url: 'http://54.175.57.150:8080/')], contextPath: 'qaenv', war: '**/*.war'
    }
  }
 }


}

