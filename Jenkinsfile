pipeline {
    agent any
    
    tools {
        maven 'maven'
    }

    stages {
        stage('git checkout') {
            steps {
               git branch: 'main', url: 'https://github.com/iamsubbu3/maven-web-application.git'
            }
        }

        stage ('maven build war file'){
            steps {
                sh 'mvn clean package'
            }
        }

        stage ('deploy to nexus') {
            steps {
                withMaven(globalMavenSettingsConfig: 'nexus-credentials', maven: 'maven', traceability: true) {
                    sh 'mvn deploy'
                }
            }
        }
    }    
}
