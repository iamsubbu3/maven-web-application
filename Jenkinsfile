pipeline {
    agent any
    
    tools {
        maven 'maven'
    }

    triggers {
        githubPush()
    }
    
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {
        stage('git checkout') {
            steps {
               git branch: 'main', url: 'https://github.com/iamsubbu3/maven-web-application.git'
            }
        }
        
        stage ('sonarqube analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                   sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectKey=code-quality-project -Dsonar.projectName=code-quality-project '''
                 }
            }
        }

        stage ('maven build war file'){
            steps {
                sh 'mvn clean package'
            }
        }
    }
        
        post {
            success {
                emailext(
                    subject: "SUCCESS: SonarQube quality gate passed",
                    body:"""
                    Hi team,
                    
                    The sonarqube quality gate passed successfully.
                    you can view the report here:
                    http://56.125.220.102:9000
                    username: admin, passwd: pass
                    
                    Regards,
                    Team DevOps,
                    clahan Technologies pvt ltd.
                    """,
                    to: 'subramanyam9979@gmail.com'
                    )
            }
            failure{
                emailext(
                    subject: 'Failed: sonarqube quality gate',
                    body:"""
                    
                    Hi Team
                    
                    The sonarqube quality gate has failed.
                    
                    Please check the below details
                    
                    http://56.125.220.102:9000
                    username: admin, passwd: pass
                    
                    Regards,
                    Team DevOps
                    """,
                    to: 'subramanyam9979@gmail.com'
                    )
            }
        }
    
}
