
node("slave1") {
  stage("git"){
    checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/bhanuprakash678910/mavenproj.git']]])
  }
   stage("maven"){
      sh 'mvn package'
  }
   stage("sonarqube"){
     sh '''mvn clean verify sonar:sonar \\
  -Dsonar.projectKey=testproj \\
  -Dsonar.host.url=http://44.200.164.54:9000 \\
  -Dsonar.login=sqp_4dce209407c0322ba5cc54a2644e28f5be48dbbf'''
  }
   stage("nexus"){
      nexusArtifactUploader artifacts: [[artifactId: '$BUILD_TIMESTAMP', classifier: '', file: 'webapp/target/webapp.war', type: 'war']], credentialsId: 'NEXUS', groupId: 'QA', nexusUrl: '44.198.178.66:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'sampletest', version: '$BUILD_ID'
  }
   stage("jfrog"){
      sh '''cp webapp/target/webapp.war webapp/target/webapp-$BUILD_ID.war
curl -uadmin:AP9DGKAQJm4mUjpf1koBh1HhXHW -T webapp/target/webapp-$BUILD_ID.war "http://3.230.118.235:8081/artifactory/samplerepo/webapp-$BUILD_ID.war"
rm -rf webapp/target/webapp-$BUILD_ID.war'''
  }
    stage("tomcat"){
	    deploy adapters: [tomcat9(credentialsId: 'tomcat_user', path: '', url: 'http://3.89.79.7:8080/')], contextPath: 'testenv', war: '**/*.war'
  }
}

